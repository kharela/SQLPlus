SET PAGESIZE 0 FEEDBACK OFF VERIFY OFF HEADING OFF ECHO OFF

-- Disable triggers
-- SPOOL disable_triggers.sql
SELECT 'ALTER table ' || owner || '.' || table_name || ' DISABLE ALL TRIGGERS;'
FROM all_tables
WHERE owner = UPPER('&schema_name');
--SPOOL OFF

-- Disable constraints
-- SPOOL disable_constraints.sql
SELECT 'ALTER TABLE ' || owner || '.' || table_name || ' DISABLE CONSTRAINT ' || constraint_name || ';'
FROM all_constraints
WHERE owner = UPPER('&schema_name')
AND constraint_type IN ('P', 'R', 'U', 'C');  -- Primary, Foreign, Unique, Check
-- SPOOL OFF

-- SPOOL truncate_tables.sql
SELECT 'TRUNCATE TABLE ' || owner || '.' || table_name || ';'
FROM all_tables
WHERE owner = UPPER('&schema_name');
-- SPOOL OFF


-- Load new data here using whatever method



-- Enable constraints
-- SPOOL disable_constraints.sql
SELECT 'ALTER TABLE ' || owner || '.' || table_name || ' ENABLE CONSTRAINT ' || constraint_name || ';'
FROM all_constraints
WHERE owner = UPPER('&schema_name')
AND constraint_type IN ('P', 'R', 'U', 'C');  -- Primary, Foreign, Unique, Check
-- SPOOL OFF

-- Enable triggers
-- SPOOL disable_triggers.sql
SELECT 'ALTER table ' || owner || '.' || table_name || ' ENABLE ALL TRIGGERS;'
FROM all_tables
WHERE owner = UPPER('&schema_name');
--SPOOL OFF
