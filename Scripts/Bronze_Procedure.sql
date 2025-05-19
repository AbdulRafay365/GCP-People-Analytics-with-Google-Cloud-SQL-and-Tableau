CREATE OR REPLACE PROCEDURE bronze.load_data()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Truncate and reload staff data
    TRUNCATE TABLE bronze.staff;
    COPY bronze.staff
    FROM 'C:/Program Files/PostgreSQL/17/Project Data/Source_Staff.csv'
    DELIMITER ','
    CSV HEADER;

    -- Truncate and reload attrition data
    TRUNCATE TABLE bronze.attrition;
    COPY bronze.attrition
    FROM 'C:/Program Files/PostgreSQL/17/Project Data/Source_Attrition.csv'
    DELIMITER ','
    CSV HEADER;
END;
$$;

CALL bronze.load_data()