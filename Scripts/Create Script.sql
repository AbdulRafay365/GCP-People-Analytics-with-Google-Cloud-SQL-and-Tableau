-- Master Database
DROP DATABASE IF EXISTS hr_data;
CREATE DATABASE hr_data
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_Canada.1252'
    LC_CTYPE = 'English_Canada.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Bronze Layer
DROP SCHEMA IF EXISTS bronze;
CREATE SCHEMA bronze;

-- Silver Layer
DROP SCHEMA IF EXISTS silver;
CREATE SCHEMA silver;

-- Gold Layer
DROP SCHEMA IF EXISTS gold;
CREATE SCHEMA gold;

