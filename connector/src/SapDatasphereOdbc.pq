section SapDatasphereOdbc;

[DataSource.Kind="SapDatasphereOdbc", Publish="SapDatasphereOdbc.Publish"]
shared SapDatasphereOdbc.Contents = (host as text, port as number, optional options as nullable record) as any =>
    let
        opt = if (options <> null) then options else [],
        encrypt = if (Record.HasFields(opt, "Encrypt")) then Record.Field(opt, "Encrypt") else true,
        validateCert = if (Record.HasFields(opt, "ValidateCertificate")) then Record.Field(opt, "ValidateCertificate") else true,
        schema = if (Record.HasFields(opt, "Schema")) then Record.Field(opt, "Schema") else null,
        serverNode = host & ":" & Number.ToText(port),
        cred = Extension.CurrentCredential(),
        username = try cred[Username] otherwise error "Username is required.",
        password = try cred[Password] otherwise error "Password is required.",
        baseConn = "Driver=HDBODBC;ServerNode=" & serverNode & ";UID=" & username & ";PWD=" & password & ";Encrypt=" & (if encrypt then "TRUE" else "FALSE") & ";sslValidateCertificate=" & (if validateCert then "TRUE" else "FALSE") & ";",
        source = Odbc.DataSource(baseConn, [ HierarchicalNavigation = true ]),
        nav = if (schema <> null) then
                let
                    // Navigate directly into the specified schema when provided
                    filtered = try source{[Name = schema, Kind = "Schema"]}[Data] otherwise error ("Schema '" & schema & "' not found.")
                in
                    filtered
              else
                source
    in
        nav;

SapDatasphereOdbc = [
    TestConnection = (host as text, port as number) => { "SapDatasphereOdbc.Contents", host, port },
    Authentication = [ UsernamePassword = [] ],
    Label = "SAP Datasphere ODBC (DirectQuery friendly)"
];

SapDatasphereOdbc.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { "SAP Datasphere ODBC", "SAP Datasphere ODBC" },
    LearnMoreUrl = "https://github.com/amitlals/SAP-BDC-Datasphere-PowerBI-Connection-accelerator"
];
