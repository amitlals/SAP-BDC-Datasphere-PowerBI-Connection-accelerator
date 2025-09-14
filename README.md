# SAP Datasphere ↔ Power BI DirectQuery Accelerator 🚀

End-to-end, read-only, DirectQuery-first accelerator to connect Microsoft Power BI to SAP Datasphere (trial) via ODBC/SAP HANA — with an optional universal ODBC custom connector. Built to be public and easy to fork. 💡

- ✅ DirectQuery prioritized (no Import back to Datasphere)
- 🔒 Read-only prototype (use least-privilege DB user)
- 🧩 Out-of-the-box ODBC connection steps
- 🧪 Connectivity test script (PowerShell)
- 🧰 Optional Power BI custom connector (universal ODBC wrapper)

> Sample user shown in examples: `GE223911` (replace with yours when needed).

## Quick Start ✨

1) Set up SAP Datasphere Trial (SAP Business Data Cloud) 🧭
- Start from SAP trial: https://www.sap.com/products/data-cloud/trial.html
- Follow the journey: https://trials.cfapps.eu10-004.hana.ondemand.com/learning-journey/bt_bdc/bdc-intro
- In BTP Cockpit, subscribe to SAP Datasphere and open the application.

2) Create a Space + Enable Database Access 🧱
- In Datasphere, create a Space for this accelerator (e.g., `ACCEL_SPACE`).
- In the Space → Settings → Database Access: Enable it and create a DB user.
- Note the generated Host and Port, plus the DB username/password.
  - You can use your user ID `GE223911` as the DB username if you set it accordingly (or use the generated DB user). 🔑

3) Install prerequisites on your Windows machine 🧩
- Power BI Desktop (64-bit)
- SAP HANA Client (includes ODBC drivers) → search for “SAP HANA Client download” on SAP Help/Software Center.
- Optional: Power Query SDK (for building the custom connector) → Visual Studio 2019/2022 or VS Code extension.

4) Test the ODBC connection locally 🧪
- Copy `scripts/.env.example` to `.env` and fill in your values (host/port/user/schema).
- Run: `powershell -ExecutionPolicy Bypass -File scripts/test_odbc.ps1` ✅

5) Connect Power BI with DirectQuery (native SAP HANA connector) 📊
- In Power BI Desktop: Get Data → SAP HANA database
- Server: `your-hostname:your-port` (from Space DB access)
- Connectivity mode: DirectQuery
- Authentication: Username/Password → use your DB user (e.g., `GE223911`) and password
- Select your schema/views; load visuals. 🎉

6) Optional: Use the Custom Connector (universal ODBC) 🧩
- Build the connector in `connector/` (see `docs/connector-dev.md`).
- Place the `.mez` in `Documents\Power BI Desktop\Custom Connectors`.
- Power BI Desktop → Options → Security → Data Extensions → Allow any extension.
- Get Data → More… → `SAP Datasphere ODBC (DirectQuery friendly)` → supply host/port → credentials.

## Read-Only by Design 🔒
- Power BI with ODBC/HANA connector issues only read queries in this accelerator.
- Use a DB user with least privileges (SELECT on the Open SQL schema and views only).
- Avoid granting write privileges in your Space for this prototype.

## Repo Structure 🗂️

- `docs/` — trial setup, ODBC connection, custom connector build
- `docs/space-sample-model.md` — minimal table, view, and sample queries with screenshots
- `connector/` — Power BI custom connector (M) and samples
- `scripts/` — ODBC connectivity tests and `.env.example`
- `samples/` — example queries and instructions

## Helpful References 🔗
- SAP Business Data Cloud (Datasphere) trial: https://www.sap.com/products/data-cloud/trial.html
- Datasphere learning journey: https://trials.cfapps.eu10-004.hana.ondemand.com/learning-journey/bt_bdc/bdc-intro
- SAP BDC/Datasphere FAQs: https://community.sap.com/t5/technology-blog-posts-by-sap/sap-business-data-cloud-faqs/ba-p/14022781
- Power BI cloud data sources: https://learn.microsoft.com/en-us/power-bi/connect-data/service-connect-cloud-data-sources

## Push to GitHub ⛳

- Create the repo `amitals/SAP-BDC-Datasphere-PowerBI-Connection-accelerator` on GitHub first.
- Then run:

```bash
git init
git add .
git commit -m "feat: DirectQuery ODBC accelerator for SAP Datasphere"
git branch -M main
git remote add origin https://github.com/amitals/SAP-BDC-Datasphere-PowerBI-Connection-accelerator.git
# or: git@github.com:amitals/SAP-BDC-Datasphere-PowerBI-Connection-accelerator.git
git push -u origin main
```



## License

Licensed under the Apache License, Version 2.0 (Apache-2.0). See `LICENSE` for details.

## Disclaimer ⚖️

- Read-only scope: DirectQuery, read-only usage. Grant least-privilege, SELECT-only access for DB users and views.
- Development connector: The optional ODBC custom connector is unsigned and for dev/testing only. For production, sign it and follow Microsoft certification guidance.
- No warranty: Scripts and examples are provided as-is. Review all SQL/config before executing. Behavior can vary by region/tenant and change with SAP trials.
- Security: Do not commit secrets. Use env vars or a secret store. Keep TLS enabled and verify certificates per your policy.
- Data protection: Use synthetic/non-sensitive data. Do not upload confidential/personal data when following examples.
- Performance & quotas: Trial quotas and DirectQuery limits can affect responsiveness and supported operations. Validate for production.
- Non‑affiliation: Not affiliated with, endorsed, or sponsored by SAP SE or Microsoft Corporation.
- Trademarks: SAP, SAP BDC/Datasphere, SAP HANA, Microsoft Power BI and others are trademarks of their owners; used here for identification only.
- Third‑party terms: Use of SAP trials, Datasphere, SAP HANA Client, Power BI, and any third‑party software is subject to their licenses/terms.
- License: Code is provided under Apache‑2.0; no warranty. See `LICENSE`.
- Screenshots: Do not copy/rehost SAP/Microsoft site images. Capture from your tenant with rights; redact sensitive info.
- Compliance: This is not legal/security/compliance advice. You are responsible for applicable laws, export controls, data protection, and internal policies.


Happy building! 🚀
