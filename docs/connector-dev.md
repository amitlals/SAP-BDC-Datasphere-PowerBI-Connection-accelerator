# Power BI Custom Connector — Universal ODBC (SAP HANA) 🧩

This optional connector wraps `Odbc.DataSource` with a DSN-less connection string for SAP HANA (Datasphere Open SQL schema), so users can connect by entering just host/port and using Power BI’s Username/Password credential flow.

> For DirectQuery, prefer the native Power BI SAP HANA connector. The custom ODBC connector is typically Import-only and provided for DSN-less convenience and a nicer navigation experience.

## Build with Power Query SDK

You can build in Visual Studio 2019/2022 or Visual Studio Code using the Power Query SDK.

- Docs & samples: https://github.com/microsoft/DataConnectors
- VS Marketplace (VS/VS Code) → search “Power Query SDK”

### VS Code (recommended for simplicity)
1) Install “Power Query SDK” extension
2) Open this repo folder
3) Build the connector
   - Command Palette → `Power Query SDK: Build` (or `pq build` if the CLI is available)
   - Output: `.mez` under `connector/dist/` (or the SDK’s default output path)

### Visual Studio
1) Install Power Query SDK (VSIX)
2) Create/open a connector project and add `connector/src/*.pq`
3) Build → Outputs a `.mez`

## Install the Connector
1) Copy the built `.mez` file to:
   - `Documents\\Power BI Desktop\\Custom Connectors`
2) Power BI Desktop → File → Options and settings → Options → Security → Data Extensions
   - Choose: `Allow any extension (not recommended)`
3) Restart Power BI Desktop

## Use in Power BI
- Get Data → More… → `SAP Datasphere ODBC (DirectQuery friendly)`
- Enter Host and Port from Datasphere Space → Database Access
- Credential: Username/Password (e.g., `GE223911`)
- Optional: After connecting, filter by schema using the navigator UI or specify `Schema` in `options` if using the advanced editor.

## Notes
- Connection string (DSN-less) uses the SAP HANA ODBC driver (`HDBODBC`) and enables TLS and certificate validation.
- The connector retrieves username/password via `Extension.CurrentCredential()`; do not hardcode secrets in code.
- For production distribution, Microsoft requires signing; for development, enabling “Allow any extension” is sufficient.

## Troubleshooting
- If the connector doesn’t appear: verify `.mez` path, security option, and restart Power BI.
- Driver not found: install SAP HANA Client 64-bit.
- SSL issues: ensure corporate trust store recognizes the server certificate or consult SAP guidance.
