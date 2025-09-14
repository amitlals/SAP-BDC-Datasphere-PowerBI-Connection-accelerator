Param(
    [string]$EnvFile = "$PSScriptRoot/.env"
)

Write-Host "🔎 Loading environment from" $EnvFile

function Load-DotEnv {
    param([string]$Path)
    if (Test-Path $Path) {
        Get-Content $Path | ForEach-Object {
            if ($_ -match "^\s*#") { return }
            if ($_ -match "^\s*$") { return }
            $parts = $_ -split '=',2
            if ($parts.Length -eq 2) {
                $key = $parts[0].Trim()
                $val = $parts[1].Trim()
                Set-Item -Path Env:$key -Value $val | Out-Null
            }
        }
    } else {
        Write-Warning "No .env file found at $Path"
    }
}

Load-DotEnv -Path $EnvFile

$hostName = $env:DSP_HOST
$port = $env:DSP_PORT
$uid = if ($env:DSP_UID) { $env:DSP_UID } else { Read-Host "Enter DB Username (e.g., GE223911)" }
$pwd = if ($env:DSP_PWD) { $env:DSP_PWD } else { Read-Host -AsSecureString "Enter DB Password" | ForEach-Object { [System.Net.NetworkCredential]::new("", $_).Password } }
$schema = $env:DSP_SCHEMA

if (-not $hostName -or -not $port) {
    Write-Error "DSP_HOST and DSP_PORT are required. Set them in $EnvFile or environment."
    exit 1
}

$conn = "Driver=HDBODBC;ServerNode=$hostName:$port;UID=$uid;PWD=$pwd;Encrypt=TRUE;sslValidateCertificate=TRUE;"
if ($schema) {
    $conn += "CURRENTSCHEMA=$schema;"
}

Add-Type -AssemblyName System.Data

try {
    $connection = New-Object System.Data.Odbc.OdbcConnection($conn)
    $connection.Open()
    Write-Host "✅ Connected to $hostName:$port as $uid"

    $command = $connection.CreateCommand()
    $command.CommandText = "SELECT CURRENT_USER, CURRENT_SCHEMA FROM DUMMY;"
    $reader = $command.ExecuteReader()
    while ($reader.Read()) {
        Write-Host ("CURRENT_USER={0} CURRENT_SCHEMA={1}" -f $reader.GetString(0), $reader.GetString(1))
    }
    $reader.Close()

    if ($schema) {
        # list first 10 objects from the schema
        $command.CommandText = "SELECT SCHEMA_NAME, TABLE_NAME FROM TABLES WHERE SCHEMA_NAME = '$schema' ORDER BY TABLE_NAME LIMIT 10;"
        $reader = $command.ExecuteReader()
        Write-Host "📋 First 10 objects in schema $schema:"
        while ($reader.Read()) {
            Write-Host (" - {0}.{1}" -f $reader.GetString(0), $reader.GetString(1))
        }
        $reader.Close()
    }

    $connection.Close()
    Write-Host "🎉 ODBC connectivity test completed successfully"
} catch {
    Write-Error $_.Exception.Message
    exit 2
}

