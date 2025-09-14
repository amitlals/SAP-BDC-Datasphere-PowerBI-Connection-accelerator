# Space Sample Model: Minimal Table, View, and Queries 🧩

Use these steps to seed a tiny dataset and expose a read-only view for Power BI DirectQuery. You can either import a CSV via the Data Builder UI or execute the SQL below in the SQL console for your Space (Open SQL schema).

> Example DB user used in screenshots/steps: `GE223911`.

## Option A — Import a CSV via Data Builder (UI) 📄
1) In your Space, go to Data Builder → New → Upload CSV
2) Select `samples/data/customers.csv`
3) Target schema: your Space Open SQL schema (shown in Space → Database Access)
4) Table name: `CUSTOMERS`
5) Finish import, then Preview to validate data.

Screenshot placeholder:
![Data Builder Import](images/04_import_csv.png "Data Builder → Upload CSV → CUSTOMERS")

## Option B — Create objects via SQL (Open SQL schema) 🧪
Run these statements in your Space SQL console. Replace `YOUR_SCHEMA` with your actual Open SQL schema name.

### 1) Create a minimal table
```sql
CREATE COLUMN TABLE "YOUR_SCHEMA"."CUSTOMERS" (
  "ID" INTEGER PRIMARY KEY,
  "NAME" NVARCHAR(100),
  "COUNTRY" NVARCHAR(50),
  "SALES" DECIMAL(15,2),
  "UPDATED_AT" TIMESTAMP
);
```

### 2) Seed a few rows
```sql
INSERT INTO "YOUR_SCHEMA"."CUSTOMERS" ("ID","NAME","COUNTRY","SALES","UPDATED_AT") VALUES
(1,'Acme GmbH','DE',120000.50,CURRENT_TIMESTAMP),
(2,'Globex Inc','US',83000.00,CURRENT_TIMESTAMP),
(3,'Initech Ltd','GB',45000.25,CURRENT_TIMESTAMP),
(4,'Umbrella SA','FR',65010.75,CURRENT_TIMESTAMP),
(5,'Soylent BV','NL',30500.00,CURRENT_TIMESTAMP);
```

### 3) Expose a read-only view for reporting
```sql
CREATE OR REPLACE VIEW "YOUR_SCHEMA"."V_SALES_BY_COUNTRY" AS
SELECT "COUNTRY",
       COUNT(*)               AS "CUSTOMERS",
       SUM("SALES")          AS "TOTAL_SALES",
       ROUND(AVG("SALES"),2) AS "AVG_SALES"
FROM   "YOUR_SCHEMA"."CUSTOMERS"
GROUP  BY "COUNTRY";
```

## Sample Queries (Sanity Checks) 🔎
Use either the SQL console or the ODBC test script to run these queries.

```sql
-- Who am I / default schema
SELECT CURRENT_USER, CURRENT_SCHEMA FROM DUMMY;

-- Confirm rows
SELECT COUNT(*) AS ROWS FROM "YOUR_SCHEMA"."CUSTOMERS";

-- Preview aggregated view
SELECT * FROM "YOUR_SCHEMA"."V_SALES_BY_COUNTRY" ORDER BY "COUNTRY";
```

## Connect from Power BI (DirectQuery) 📊
- Get Data → SAP HANA database
- Server: `host:port` from Space → Database Access
- Connectivity mode: DirectQuery
- Authentication: Username/Password (use your DB user, e.g., `GE223911`)
- Select `YOUR_SCHEMA` → `V_SALES_BY_COUNTRY` → Load 🎉

Screenshot placeholders:
- ![PBI Get Data](images/05_pbi_get_data.png "Power BI Desktop → Get Data → SAP HANA database")
- ![PBI Server](images/06_pbi_server.png "Server = host:port, DirectQuery mode")
- ![PBI Navigator](images/07_pbi_navigator.png "Navigator → Select YOUR_SCHEMA.V_SALES_BY_COUNTRY")

## Files in this repo that help 💡
- `samples/data/customers.csv` — tiny seed dataset
- `samples/sql/01_create_table.sql` — create `CUSTOMERS`
- `samples/sql/02_insert_sample_data.sql` — insert sample rows
- `samples/sql/03_create_view.sql` — create `V_SALES_BY_COUNTRY`
- `samples/sql/04_sample_queries.sql` — sanity queries

