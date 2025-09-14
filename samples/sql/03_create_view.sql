-- Create a simple read-only view for reporting
CREATE OR REPLACE VIEW "YOUR_SCHEMA"."V_SALES_BY_COUNTRY" AS
SELECT "COUNTRY",
       COUNT(*)               AS "CUSTOMERS",
       SUM("SALES")          AS "TOTAL_SALES",
       ROUND(AVG("SALES"),2) AS "AVG_SALES"
FROM   "YOUR_SCHEMA"."CUSTOMERS"
GROUP  BY "COUNTRY";

