# Connect Power BI via ODBC/SAP HANA (DirectQuery-first) 📊

This accelerator prioritizes DirectQuery using Power BI’s native SAP HANA connector. It also includes a universal ODBC custom connector as an optional path.

> Use the Host and Port from your Space’s Database Access page in SAP Datasphere.

## Option A — Native SAP HANA Connector (Recommended for DirectQuery)

1) Open Power BI Desktop → Get Data → SAP HANA database
2) Server: `your-hostname:your-port` (from Datasphere Space DB access)
3) Connectivity mode: DirectQuery
4) Authentication: Username/Password
   - Username: your DB user (e.g., `GE223911`)
   - Password: your DB user password
5) Select your schema (Open SQL Schema) and views/tables → Load

Notes:
- This is the most reliable DirectQuery path.
- Ensure SAP HANA Client is installed (ODBC driver present) on the machine.

Screenshot placeholders:
- ![PBI Get Data](images/05_pbi_get_data.png "Power BI Desktop → Get Data → SAP HANA database")
- ![PBI Server](images/06_pbi_server.png "Server = host:port, DirectQuery mode")
- ![PBI Navigator](images/07_pbi_navigator.png "Navigator → Select schema views")

## Option B — Universal ODBC Custom Connector (Import-oriented)

Power BI’s generic ODBC path is typically Import mode. A custom connector can wrap ODBC (DSN-less) to simplify connection and schema navigation.

- Build the connector in `connector/` (see `docs/connector-dev.md`).
- Place `.mez` in `Documents\\Power BI Desktop\\Custom Connectors`.
- Power BI Desktop → Options → Security → Data Extensions → Allow any extension (not recommended) → OK → Restart.
- Get Data → More… → `SAP Datasphere ODBC (DirectQuery friendly)`
- Enter host and port. When prompted, choose Username/Password (use your DB user) → Connect.

Screenshot placeholder:
![Custom Connector](images/08_custom_connector.png "Get Data → SAP Datasphere ODBC (custom)")

## DSN-less ODBC Examples 🔧

Example connection string used by the test script and connector (replace placeholders):

```
Driver=HDBODBC;ServerNode=YOUR_HOST:YOUR_PORT;UID=GE223911;PWD=YOUR_PASSWORD;Encrypt=TRUE;sslValidateCertificate=TRUE;CURRENTSCHEMA=YOUR_SCHEMA;
```

- `Driver=HDBODBC` is the standard SAP HANA ODBC driver name on 64‑bit Power BI.
- Always use the exact Host and Port provided by Datasphere → Space → Database Access.
- Optionally set `CURRENTSCHEMA` to control default schema.

## Quick ODBC Sanity Query 🧪

Use the PowerShell test script or query:

```sql
SELECT CURRENT_USER, CURRENT_SCHEMA FROM DUMMY;
```

If that succeeds, your ODBC connectivity is ready.

## Troubleshooting 🛠️
- Driver not found: Ensure SAP HANA Client is installed (64-bit) and restart Power BI.
- SSL/cert: Keep `Encrypt=TRUE;sslValidateCertificate=TRUE;`. If you see certificate errors, verify your corporate trust store or consult SAP HANA Client docs.
- DirectQuery not available: Use the native SAP HANA connector (Option A). ODBC connectors are typically Import-only.
- No objects visible: Verify your DB user has SELECT on expected schema/tables/views.

## References 🔗
- Power BI cloud data sources: https://learn.microsoft.com/en-us/power-bi/connect-data/service-connect-cloud-data-sources
- SAP Business Data Cloud / Datasphere trial: https://www.sap.com/products/data-cloud/trial.html
