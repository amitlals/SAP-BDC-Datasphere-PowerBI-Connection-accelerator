section SapDatasphereOdbc;

// Sample queries for Power Query SDK test harness

shared Query_Datasphere_ListAll =
    let
        host = "YOUR_HOSTNAME",
        port = 443,
        source = SapDatasphereOdbc.Contents(host, port)
    in
        source;

shared Query_Datasphere_Schema =
    let
        host = "YOUR_HOSTNAME",
        port = 443,
        source = SapDatasphereOdbc.Contents(host, port, [ Schema = "YOUR_SCHEMA" ])
    in
        source;

