# Screenshot Checklist and Naming 📸

To keep the README and docs rendering clean, capture and save screenshots using the exact filenames below under `docs/images/`.

Legal note: Do not download, copy, or rehost images from SAP’s websites (including the learning journey). Instead, capture your own screenshots from your tenant and tools. You may link to SAP pages when appropriate.

## Images and where to capture

1. `00_start_trial.png` — BTP trial landing page (pre-login splash, no personal data)
2. `01_btp_subscribe.png` — BTP Cockpit → Subaccount → Subscriptions → SAP Datasphere → Subscribe
3. `02_create_space.png` — SAP Datasphere → Spaces → Create Space dialog (mask sensitive info)
4. `03_db_access.png` — Space → Settings → Database Access (show Host/Port and DB user; blur secrets)
5. `04_import_csv.png` — Data Builder → Upload CSV → file selected (customers.csv) → Preview
6. `05_pbi_get_data.png` — Power BI Desktop → Get Data → SAP HANA database
7. `06_pbi_server.png` — Power BI Desktop → SAP HANA dialog showing `server = host:port`, DirectQuery selected
8. `07_pbi_navigator.png` — Power BI Navigator window with `YOUR_SCHEMA.V_SALES_BY_COUNTRY` highlighted
9. `08_custom_connector.png` — Power BI → Get Data → custom connector list item (if you build the .mez)

## Capture tips
- Resolution: 1280–1600px width is sufficient; keep aspect ratio consistent
- Redact: blur/cover passwords, tenant IDs, and any proprietary names
- Theme: use Light or consistent theme across screenshots
- Format: PNG preferred for crisp UI visuals
- Storage: place under `docs/images/` exactly as named above

## Optional link-back (attribution)
- Learning journey page (link only): https://trials.cfapps.eu10-004.hana.ondemand.com/learning-journey/bt_bdc/bdc-intro
- Datasphere trial page (link only): https://www.sap.com/products/data-cloud/trial.html

