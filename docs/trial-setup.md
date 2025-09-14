# SAP Datasphere Trial Setup (SAP Business Data Cloud) 🧭

This guide gets you from zero to a Space with Database Access enabled so you can connect from Power BI using DirectQuery via the SAP HANA connector (and optionally the custom ODBC connector).

## 1) Start the Trial
- Go to: https://www.sap.com/products/data-cloud/trial.html
- Follow the learning journey: https://trials.cfapps.eu10-004.hana.ondemand.com/learning-journey/bt_bdc/bdc-intro
- Create/choose your SAP BTP global account and region (EU10 is common for trials but choose what’s available).

Screenshot placeholder:
![Start Trial](images/00_start_trial.png "BTP Trial landing page → Start trial")

## 2) Subscribe to SAP Datasphere
- In BTP Cockpit → Subaccount → Subscriptions → search for “SAP Datasphere” and Subscribe.
- Open the application.

Screenshot placeholder:
![BTP Subscribe](images/01_btp_subscribe.png "BTP Subscriptions → SAP Datasphere → Subscribe")

## 3) Create a Space
- In SAP Datasphere, create a Space (e.g., `ACCEL_SPACE`).
- Assign yourself role collections such as Data Warehouse Administrator/Modeler if required by your org policy.

Screenshot placeholder:
![Create Space](images/02_create_space.png "Datasphere → Spaces → Create Space")

## 4) Enable Database Access (Open SQL Schema) 🔑
- In your Space → Settings → Database Access → Enable.
- Create a DB user (store username and password securely).
- Note the generated values:
  - Host
  - Port
  - Open SQL Schema name (optional but very useful)

These Host/Port values are what you will use in Power BI (e.g., `server = host:port`).

Screenshot placeholder:
![DB Access](images/03_db_access.png "Space Settings → Database Access → Host/Port and DB User")

## 5) Read-Only Posture 🔒
- For this accelerator, keep it read-only:
  - Use (or create) a DB user with only SELECT on relevant objects in your Space’s Open SQL schema.
  - Avoid granting write privileges and avoid modeling write-back scenarios.

## 6) (Optional) Sample Data
- Load a small CSV into a table in your Space or create a simple SQL view.
- Ensure you can query it in Datasphere (Data Builder → Preview) before connecting from Power BI.
- See: `docs/space-sample-model.md` for a minimal table, view, and queries.

Screenshot placeholder:
![Data Builder Import](images/04_import_csv.png "Data Builder → Import CSV")

## References
- SAP Business Data Cloud FAQs: https://community.sap.com/t5/technology-blog-posts-by-sap/sap-business-data-cloud-faqs/ba-p/14022781
