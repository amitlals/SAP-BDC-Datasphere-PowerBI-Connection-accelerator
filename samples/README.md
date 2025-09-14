# Samples 📦

This folder holds lightweight examples you can use to validate connectivity without shipping binary `.pbit` files.

## Power BI (Advanced Editor) — Sample M queries

Paste into a Blank Query in Power BI Desktop → Advanced Editor.

### List all (navigator)
```m
let
  Source = SapDatasphereOdbc.Contents("YOUR_HOSTNAME", 443)
in
  Source
```

### Focus a specific schema
```m
let
  Source = SapDatasphereOdbc.Contents("YOUR_HOSTNAME", 443, [ Schema = "YOUR_SCHEMA" ])
in
  Source
```

Replace host/port/schema with your values and provide Username/Password when prompted.

For DirectQuery, prefer: Get Data → SAP HANA database (native connector) → DirectQuery.
