-- Service Principal: read access to the shared raw data
GRANT USE CATALOG ON CATALOG raw_marketing TO bd1b0529-7ae7-4f05-9236-0119aecf564a;
GRANT USE SCHEMA, SELECT ON SCHEMA raw_marketing.ads_schema TO bd1b0529-7ae7-4f05-9236-0119aecf564a;

-- Service Principal: build access in production
GRANT USE CATALOG, USE SCHEMA, CREATE SCHEMA, CREATE TABLE
  ON CATALOG prod_catalog TO bd1b0529-7ae7-4f05-9236-0119aecf564a;

-- Service Principal: build access in CI
GRANT USE CATALOG, USE SCHEMA, CREATE SCHEMA, CREATE TABLE
  ON CATALOG ci_catalog TO bd1b0529-7ae7-4f05-9236-0119aecf564a;

-- You: read access to inspect what CI built
GRANT USE CATALOG, USE SCHEMA, SELECT
  ON CATALOG ci_catalog TO bewarangritmwa@gmail.com;