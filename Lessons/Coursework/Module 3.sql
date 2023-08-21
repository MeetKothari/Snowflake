-- CREATE OR REPLACE FILE FORMAT INTL_DB.PUBLIC.PIPE_DBLQUOTE_HEADER_CR 
--   TYPE = 'CSV' 
--   COMPRESSION = 'AUTO' 
--   FIELD_DELIMITER = '|' 
--   RECORD_DELIMITER = '\r' 
--   SKIP_HEADER = 1 
--   FIELD_OPTIONALLY_ENCLOSED_BY = '\042' 
--   TRIM_SPACE = FALSE 
--   ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE 
--   ESCAPE = 'NONE' 
--   ESCAPE_UNENCLOSED_FIELD = '\134'
--   DATE_FORMAT = 'AUTO' 
--   TIMESTAMP_FORMAT = 'AUTO' 
--   NULL_IF = ('\\N');

-- copy into INTL_DB.PUBLIC.INT_STDS_ORG_3661
-- from @util_db.public.like_a_window_into_an_s3_bucket
-- files = ( 'smew/ISO_Countries_UTF8_pipe.csv')
-- file_format = ( format_name='INTL_DB.PUBLIC.PIPE_DBLQUOTE_HEADER_CR' );

-- CREATE or replace VIEW NATIONS_SAMPLE_PLUS_ISO 
-- ( iso_country_name
--   ,country_name_official
--   ,alpha_code_2digit
--   ,region) AS
--   SELECT  
--     iso_country_name
--     , country_name_official,alpha_code_2digit
--     ,r_name as region
-- FROM INTL_DB.PUBLIC.INT_STDS_ORG_3661 i
-- LEFT JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.NATION n
-- ON UPPER(i.iso_country_name)=n.n_name
-- LEFT JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.REGION r
-- ON n_regionkey = r_regionkey;
-- ;

-- SELECT *
-- FROM INTL_DB.PUBLIC.NATIONS_SAMPLE_PLUS_ISO;

-- -- set your worksheet drop lists to the location of your GRADER function
-- -- SET YOUR DROPLISTS PRIOR TO RUNNING THE CODE BELOW 

-- --DO NOT EDIT BELOW THIS LINE
-- select grader(step, (actual = expected), actual, expected, description) as graded_results from(
-- SELECT 'SMEW04' as step
--  ,(select count(*) 
--    from INTL_DB.PUBLIC.NATIONS_SAMPLE_PLUS_ISO) as actual
--  , 249 as expected
--  ,'Nations Sample Plus Iso' as description
-- );


-- CREATE TABLE INTL_DB.PUBLIC.CURRENCIES 
-- (
--   CURRENCY_ID INTEGER, 
--   CURRENCY_CHAR_CODE varchar(3), 
--   CURRENCY_SYMBOL varchar(4), 
--   CURRENCY_DIGITAL_CODE varchar(3), 
--   CURRENCY_DIGITAL_NAME varchar(30)
-- )
--   COMMENT = 'Information about currencies including character codes, symbols, digital codes, etc.';



--   CREATE TABLE INTL_DB.PUBLIC.COUNTRY_CODE_TO_CURRENCY_CODE 
--   (
--     COUNTRY_CHAR_CODE Varchar(3), 
--     COUNTRY_NUMERIC_CODE INTEGER, 
--     COUNTRY_NAME Varchar(100), 
--     CURRENCY_NAME Varchar(100), 
--     CURRENCY_CHAR_CODE Varchar(3), 
--     CURRENCY_NUMERIC_CODE INTEGER
--   ) 
--   COMMENT = 'Many to many code lookup table';

--   CREATE FILE FORMAT INTL_DB.PUBLIC.CSV_COMMA_LF_HEADER
--   TYPE = 'CSV'
--   COMPRESSION = 'AUTO' 
--   FIELD_DELIMITER = ',' 
--   RECORD_DELIMITER = '\n' 
--   SKIP_HEADER = 1 
--   FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE' 
--   TRIM_SPACE = FALSE 
--   ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE 
--   ESCAPE = 'NONE' 
--   ESCAPE_UNENCLOSED_FIELD = '\134' 
--   DATE_FORMAT = 'AUTO' 
--   TIMESTAMP_FORMAT = 'AUTO' 
--   NULL_IF = ('\\N');

-- copy into INTL_DB.PUBLIC.COUNTRY_CODE_TO_CURRENCY_CODE  
-- from @like_a_window_into_an_s3_bucket
-- files = ( 'smew/country_code_to_currency_code.csv')
-- file_format = ( format_name='INTL_DB.PUBLIC.CSV_COMMA_LF_HEADER' );

--   -- set your worksheet drop lists to the location of your GRADER function

-- -- set your worksheet drop lists to the location of your GRADER function

-- --DO NOT EDIT BELOW THIS LINE
-- select grader(step, (actual = expected), actual, expected, description) as graded_results from(
-- SELECT 'SMEW06' as step
--  ,(select row_count 
--   from INTL_DB.INFORMATION_SCHEMA.TABLES 
--   where table_schema = 'PUBLIC' 
--   and table_name = 'CURRENCIES') as actual
--  , 151 as expected
--  ,'Currencies table loaded' as description
-- );

-- create or replace view SIMPLE_CURRENCY
-- ( CTY_CODE 
--   ,CUR_CODE )AS
--     SELECT 
--         COUNTRY_CHAR_CODE
--         ,CURRENCY_CHAR_CODE
--     FROM
--         INTL_DB.PUBLIC.COUNTRY_CODE_TO_CURRENCY_CODE

-- select * from simple_currency

-- -- set your worksheet drop lists to the location of your GRADER function

-- --DO NOT EDIT BELOW THIS LINE
-- select grader(step, (actual = expected), actual, expected, description) as graded_results from(
--  SELECT 'SMEW07' as step 
-- ,(select count(*) 
--   from INTL_DB.PUBLIC.SIMPLE_CURRENCY ) as actual
-- , 265 as expected
-- ,'Simple Currency Looks Good' as description
-- );

ALTER VIEW INTL_DB.PUBLIC.NATIONS_SAMPLE_PLUS_ISO
SET SECURE; 

ALTER VIEW INTL_DB.PUBLIC.NATIONS_SAMPLE_PLUS_ISO
SET SECURE; 

ALTER VIEW INTL_DB.PUBLIC.SIMPLE_CURRENCY
SET SECURE;

SHOW MANAGED ACCOUNTS;

-- set your worksheet drop lists to the location of your GRADER function
-- DO NOT EDIT ANYTHING BELOW THIS LINE
select grader(step, (actual = expected), actual, expected, description) as graded_results from
(
SELECT 
 'SMEW08' as step
 ,(select count(*)/NULLIF(count(*),0) from snowflake.reader_account_usage.query_history
where USER_NAME = 'MANAGED_READER_ADMIN' and query_text ilike ('%366%')) as actual
 , 1 as expected
 ,'03-00-01-08' as description
UNION ALL
SELECT 
  'SMEW09' as step
 ,(select count(*)/NULLIF(count(*),0) from snowflake.reader_account_usage.query_history
where USER_NAME = 'MANAGED_READER_ADMIN' and query_text ilike ('%NCIES%')) as actual
 , 1 as expected
 ,'03-00-01-09' as description
UNION ALL
SELECT 
  'SMEW10' as step
 ,(select count(*)/NULLIF(count(*),0) from snowflake.reader_account_usage.query_history
where USER_NAME = 'MANAGED_READER_ADMIN' and query_text ilike ('%IMPLE%')) as actual
 , 1 as expected
 ,'03-00-01-10' as description
UNION ALL 
SELECT 
    'SMEW11' as step 
,(select count(*)/NULLIF(count(*),0) from snowflake.reader_account_usage.query_history
where USER_NAME = 'MANAGED_READER_ADMIN' and query_text ilike ('%DE_TO%')) as actual
, 1 as expected
,'03-00-01-11' as description
); 


create database ACME;

--did Snowflake set your worksheet database to the new database? 
--if not, you can do it yourself.
use database ACME;

--get rid of the public schema - too generic
drop schema PUBLIC;

--When creating shares it is best to have multiple schemas
create schema ACME.SALES;
create schema ACME.STOCK;
create schema ACME.ADU; --this is the schema they'll use to share to ADU, Max's company

create or replace table ACME.STOCK.LOTSTOCK
(
 VIN VARCHAR(17)
,EXTERIOR VARCHAR(50)	
,INTERIOR VARCHAR(50)
,DATE_SOLD DATE
,CUSTOMER_ID NUMBER(20)
);

--This secure view breaks the VIN into digestible components
--this view only shares unsold cars because the unsold cars
--are the ones that need to be enhanced
create or replace secure view ACME.ADU.LOTSTOCK 
AS (
SELECT VIN
  , LEFT(VIN,3) as WMI
  , SUBSTR(VIN,4,5) as VDS
  , SUBSTR(VIN,10,1) as MODYEARCODE
  , SUBSTR(VIN,11,1) as PLANTCODE
  , EXTERIOR
  , INTERIOR
FROM ACME.STOCK.LOTSTOCK
WHERE DATE_SOLD is NULL
);

--You need a file format if you want to load the table
create file format ACME.STOCK.COMMA_SEP_HEADERROW 
TYPE = 'CSV' 
COMPRESSION = 'AUTO' 
FIELD_DELIMITER = ',' 
RECORD_DELIMITER = '\n' 
SKIP_HEADER = 1 
FIELD_OPTIONALLY_ENCLOSED_BY = '\042'  
TRIM_SPACE = TRUE 
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE 
ESCAPE = 'NONE' 
ESCAPE_UNENCLOSED_FIELD = '\134' 
DATE_FORMAT = 'AUTO' 
TIMESTAMP_FORMAT = 'AUTO' 
NULL_IF = ('\\N');

--Use a COPY INTO to load the data
--the file is named Lotties_LotStock_Data.csv

COPY INTO acme.stock.lotstock
from @util_db.public.like_a_window_into_an_s3_bucket
files = ('smew/Lotties_LotStock_Data.csv')
file_format =(format_name=ACME.STOCK.COMMA_SEP_HEADERROW);


-- After loading your base table is no longer empty
-- it should now have 300 rows
select * from acme.stock.lotstock;

--the View will show just 298 rows because the view only shows
--rows where the date_sold is null
select * from acme.adu.lotstock;

-- set your worksheet drop lists to the location of your GRADER function
--DO NOT EDIT ANYTHING BELOW THIS LINE
select grader(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'SMEW12' as step
 ,(select count(*) 
   from SNOWFLAKE.ACCOUNT_USAGE.DATABASES 
   where database_name in ('INTL_DB','DEMO_DB','ACME', 'ACME_DETROIT','ADU_VINHANCED') 
   and deleted is null) as actual
 , 5 as expected
 ,'Databases from all over!' as description
); 


alter DATABASE ACME rename to back_when_i_pretended_i_was_caden;

--Max created a database to store Vehicle Identification Numbers
CREATE DATABASE max_vin;

DROP SCHEMA max_vin.public;
CREATE SCHEMA max_vin.decode;

--We need a table that will allow WMIs to be decoded into Manufacturer Name, Country and Vehicle Type
CREATE TABLE MAX_VIN.DECODE.WMITOMANUF 
(
     WMI	        VARCHAR(6)
    ,MANUF_ID	    NUMBER(6)
    ,MANUF_NAME	    VARCHAR(50)
    ,COUNTRY	    VARCHAR(50)
    ,VEHICLETYPE    VARCHAR(50)
 );
 
--We need a table that will allow you to go from Manufacturer to Make
--For example, Mercedes AG of Germany and Mercedes USA both roll up into Mercedes
--But they use different WMI Codes
CREATE TABLE MAX_VIN.DECODE.MANUFTOMAKE
(
     MANUF_ID	NUMBER(6)
    ,MAKE_NAME	VARCHAR(50)
    ,MAKE_ID	NUMBER(5)
);

--We need a table that can decode the model year
-- The year 2001 is represented by the digit 1
-- The year 2020 is represented by the letter L
CREATE TABLE MAX_VIN.DECODE.MODELYEAR
(
     MODYEARCODE	VARCHAR(1)
    ,MODYEARNAME	NUMBER(4)
);

--We need a table that can decode which plant at which 
--the vehicle was assembled
--You might have code "A" for Honda and code "A" for Ford
--so you need both the Make and the Plant Code to properly decode 
--the plant code
CREATE TABLE MAX_VIN.DECODE.MANUFPLANTS
(
     MAKE_ID	NUMBER(5)
    ,PLANTCODE	VARCHAR(1)
    ,PLANTNAME	VARCHAR(75)
 );
 
--We need to use a combination of both the Make and VDS 
--to decode many attributes including the engine, transmission, etc
CREATE TABLE MAX_VIN.DECODE.MMVDS
(
     MAKE_ID	NUMBER(3)
    ,MODEL_ID	NUMBER(6)
    ,MODEL_NAME	VARCHAR(50)
    ,VDS	VARCHAR(5)
    ,DESC1	VARCHAR(25)
    ,DESC2	VARCHAR(25)
    ,DESC3	VARCHAR(50)
    ,DESC4	VARCHAR(25)
    ,DESC5	VARCHAR(25)
    ,BODYSTYLE	VARCHAR(25)
    ,ENGINE	VARCHAR(100)
    ,DRIVETYPE	VARCHAR(50)
    ,TRANS	VARCHAR(50)
    ,MPG	VARCHAR(25)
);

--Create a file format and then load each of the 5 Lookup Tables
--You need a file format if you want to load the table
CREATE FILE FORMAT MAX_VIN.DECODE.COMMA_SEP_HEADERROW 
TYPE = 'CSV' 
COMPRESSION = 'AUTO' 
FIELD_DELIMITER = ',' 
RECORD_DELIMITER = '\n' 
SKIP_HEADER = 1 
FIELD_OPTIONALLY_ENCLOSED_BY = '\042'  
TRIM_SPACE = TRUE 
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE 
ESCAPE = 'NONE' 
ESCAPE_UNENCLOSED_FIELD = '\134' 
DATE_FORMAT = 'AUTO' 
TIMESTAMP_FORMAT = 'AUTO' 
NULL_IF = ('\\N');

create stage demo_db.public.like_a_window_into_an_s3_bucket
url = 's3://uni-lab-files';

list @demo_db.public.like_a_window_into_an_s3_bucket/smew;
/*
smew/Maxs_MMVDS_Data.csv
smew/Maxs_ManufPlants_Data.csv
smew/Maxs_ManufToMake_Data.csv
smew/Maxs_ModelYear_Data.csv
smew/Maxs_WMIToManuf_data.csv
*/

COPY INTO MAX_VIN.DECODE.WMITOMANUF
from @demo_db.public.like_a_window_into_an_s3_bucket
files = ('smew/Maxs_WMIToManuf_data.csv')
file_format =(format_name=MAX_VIN.DECODE.COMMA_SEP_HEADERROW);

COPY INTO MAX_VIN.DECODE.MANUFTOMAKE
from @demo_db.public.like_a_window_into_an_s3_bucket
files = ('smew/Maxs_ManufToMake_Data.csv')
file_format =(format_name=MAX_VIN.DECODE.COMMA_SEP_HEADERROW);

COPY INTO MAX_VIN.DECODE.MODELYEAR
from @demo_db.public.like_a_window_into_an_s3_bucket
files = ('smew/Maxs_ModelYear_Data.csv')
file_format =(format_name=MAX_VIN.DECODE.COMMA_SEP_HEADERROW);

COPY INTO MAX_VIN.DECODE.MANUFPLANTS
from @demo_db.public.like_a_window_into_an_s3_bucket
files = ('smew/Maxs_ManufPlants_Data.csv')
file_format =(format_name=MAX_VIN.DECODE.COMMA_SEP_HEADERROW);

COPY INTO MAX_VIN.DECODE.MMVDS
from @demo_db.public.like_a_window_into_an_s3_bucket
files = ('smew/Maxs_MMVDS_Data.csv')
file_format =(format_name=MAX_VIN.DECODE.COMMA_SEP_HEADERROW);

--Max has Lottie's VINventory table. Now he'll join his decode tables to the data
-- He'll create a select statement that ties each table into Lottie's VINS
-- Every time he adds a new table, he'll make sure he still has 298 rows

SELECT *
FROM ACME_DETROIT.ADU.LOTSTOCK l-- he uses Lottie's data from the INBOUND SHARE 
JOIN MAX_VIN.DECODE.MODELYEAR y -- and confirms he can join it with his own decode data
ON l.modyearcode=y.modyearcode;

SELECT *
FROM ACME_DETROIT.ADU.LOTSTOCK l -- he uses Lottie's data from the INBOUND SHARE 
JOIN MAX_VIN.DECODE.WMITOMANUF w -- and confirms he can join it with his own decode data
ON l.WMI=w.WMI;

--Add the next table (still 298?)
SELECT *
FROM ACME_DETROIT.ADU.LOTSTOCK l -- he uses Lottie's data from the INBOUND SHARE 
JOIN MAX_VIN.DECODE.WMITOMANUF w -- and confirms he can join it with his own decode data 
ON l.WMI=w.WMI
JOIN MAX_VIN.DECODE.MANUFTOMAKE m
ON w.manuf_id=m.manuf_id;

--Until finally he has all 5 lookup tables added
--He can then remove the asterisk and start narrowing down the 
--fields to include in the final output
SELECT 
l.VIN
,y.MODYEARNAME
,m.MAKE_NAME
,v.DESC1
,v.DESC2
,v.DESC3
,BODYSTYLE
,ENGINE
,DRIVETYPE
,TRANS
,MPG
,MANUF_NAME
,COUNTRY
,VEHICLETYPE
,PLANTNAME
FROM ACME_DETROIT.ADU.LOTSTOCK l -- he joins Lottie's data from the INBOUND SHARE 
JOIN MAX_VIN.DECODE.WMITOMANUF w -- with all his data (he just tested)
    ON l.WMI=w.WMI
JOIN MAX_VIN.DECODE.MANUFTOMAKE m
    ON w.manuf_id=m.manuf_id
JOIN MAX_VIN.DECODE.MANUFPLANTS p
    ON l.plantcode=p.plantcode
    AND m.make_id=p.make_id
JOIN MAX_VIN.DECODE.MMVDS v
    ON v.vds=l.vds 
    and v.make_id = m.make_id
JOIN MAX_VIN.DECODE.MODELYEAR y
    ON l.modyearcode=y.modyearcode;

    -- Once the select statement looks good (above), Max lays a view on top of it
-- this will make it easier to use in a Stored procedure

USE ROLE SYSADMIN;
CREATE DATABASE MAX_OUTGOING; --this new database will be used for his OUTBOUND SHARE
CREATE SCHEMA MAX_OUTGOING.FOR_ACME; --this schema he creates especially for ACME

-- This is a live view of the data Lottie and Caden Need!
CREATE OR REPLACE SECURE VIEW MAX_OUTGOING.FOR_ACME.LOTSTOCKENHANCED as 
(
SELECT 
l.VIN
,y.MODYEARNAME
,m.MAKE_NAME
,v.DESC1
,v.DESC2
,v.DESC3
,BODYSTYLE
,ENGINE
,DRIVETYPE
,TRANS
,MPG
,EXTERIOR
,INTERIOR
,MANUF_NAME
,COUNTRY
,VEHICLETYPE
,PLANTNAME
FROM ACME_DETROIT.ADU.LOTSTOCK l
JOIN MAX_VIN.DECODE.WMITOMANUF w
    ON l.WMI=w.WMI
JOIN MAX_VIN.DECODE.MANUFTOMAKE m
    ON w.manuf_id=m.manuf_id
JOIN MAX_VIN.DECODE.MANUFPLANTS p
    ON l.plantcode=p.plantcode
    AND m.make_id=p.make_id
JOIN MAX_VIN.DECODE.MMVDS v
    ON v.vds=l.vds and v.make_id = m.make_id
JOIN MAX_VIN.DECODE.MODELYEAR y
    ON l.modyearcode=y.modyearcode
);

-- Even though it would be nice to share the view back to Lottie, 
-- You can't share a share so we have to make a copy of the data to share back

CREATE OR REPLACE TABLE MAX_OUTGOING.FOR_ACME.LOTSTOCKRETURN
(
     VIN	        VARCHAR(17)
    ,MODYEARNAME	NUMBER(4)
    ,MAKE_NAME	    VARCHAR(50)
    ,DESC1	        VARCHAR(50)
    ,DESC2	        VARCHAR(50)
    ,DESC3	        VARCHAR(50)
    ,BODYSTYLE	    VARCHAR(25)
    ,ENGINE	        VARCHAR(100)
    ,DRIVETYPE	    VARCHAR(50)
    ,TRANS	        VARCHAR(50)
    ,MPG	        VARCHAR(25)
    ,EXTERIOR	    VARCHAR(50)
    ,INTERIOR	    VARCHAR(50)
    ,MANUF_NAME	    VARCHAR(50)
    ,COUNTRY	    VARCHAR(50)
    ,VEHICLETYPE	VARCHAR(50)
    ,PLANTNAME	    VARCHAR(75)
  );

  create or replace procedure lotstockupdate_sp()
  returns string not null
  language javascript
  as
  $$
    var my_sql_command1 = "truncate table max_outgoing.for_acme.lotstockreturn;";
    var statement1 = snowflake.createStatement( {sqlText: my_sql_command1} );
    var result_set1 = statement1.execute();
    
    var my_sql_command2 ="insert into max_outgoing.for_acme.lotstockreturn ";    
    my_sql_command2 += "select VIN, MODYEARNAME, MAKE_NAME, DESC1, DESC2, DESC3, BODYSTYLE";
    my_sql_command2 += ",ENGINE, DRIVETYPE, TRANS, MPG, EXTERIOR, INTERIOR, MANUF_NAME, COUNTRY, VEHICLETYPE, PLANTNAME";
    my_sql_command2 += " from max_outgoing.for_acme.lotstockenhanced;";

    var statement2 = snowflake.createStatement( {sqlText: my_sql_command2} ); 
    var result_set2 = statement2.execute(); 
    return my_sql_command2; 
   $$; 
   
   --View your Stored Procedure 
   show procedures in account; 
   desc procedure lotstockupdate_sp(); 


 --==========SCHEDULED TASK============================================== 
-- Create a task that calls the stored procedure every hour 
-- so that Lottie sees updates at least every hour

USE ROLE ACCOUNTADMIN;
grant execute task on account to role sysadmin;
create or replace task acme_return_update
  warehouse = compute_wh
  schedule = '1 minute'
as
  call lotstockupdate_sp();

--if you need to see who owns the task
show grants on task acme_return_update;
 
--Look at the task you just created to make sure it turned out okay
show tasks;
desc task acme_return_update;
 
--if you task has a state of "suspended" run this to get it going
alter task acme_return_update resume;  
 
--Check back 5 mins later to make sure your task has been running
--You will not be able to see your task on the Query History Tab
select *
  from table(information_schema.task_history())
  order by scheduled_time;


--=== CHECK ON AND SUSPEND THE SCHEDULED TASK ========================== 
show tasks in account;
alter task acme_return_update resume;
desc task acme_return_update;
 
alter task acme_return_update suspend;  
 
--Check back 5 mins later to make sure your task is NOT running
desc task acme_return_update;

-- set the worksheet drop lists to match the location of your GRADER function

--DO NOT MAKE ANY CHANGES BELOW THIS LINE
select grader(step, (actual = expected), actual, expected, description) as graded_results from
(
SELECT 'SMEW13' as step
 ,(select count(*) 
   from MAX_OUTGOING.FOR_ACME.LOTSTOCKRETURN) as actual
 , 298 as expected
 ,'LotStockReturn Table loaded' as description
); 

create or replace secure view DEMO_DB.PUBLIC.DETROIT_ZIPS
AS (
SELECT DISTINCT postal_code
FROM WEATHERSOURCE.STANDARD_TILE.HISTORY_DAY
WHERE left (postal_code, 3) IN ('481', '482')
);


-- set the worksheet drop lists to match the location of your GRADER function
--DO NOT MAKE ANY CHANGES BELOW THIS LINE
select grader(step, (actual = expected), actual, expected, description) as graded_results from (
SELECT 
  'SMEW14' as step
 ,(select count(*) 
   from DEMO_DB.PUBLIC.DETROIT_ZIPS) as actual
 , 9 as expected
 ,'Detroit Zips' as description
); 

-- set your worksheet drop lists to the location of your GRADER function
-- DO NOT EDIT ANYTHING BELOW THIS LINE
select grader(step, (actual = expected), actual, expected, description) as graded_results from
(
SELECT 
 'SMEW08' as step
 ,(select count(*)/NULLIF(count(*),0) from snowflake.reader_account_usage.query_history
where USER_NAME = 'MANAGED_READER_ADMIN' and query_text ilike ('%366%')) as actual
 , 1 as expected
 ,'03-00-01-08' as description
UNION ALL
SELECT 
  'SMEW09' as step
 ,(select count(*)/NULLIF(count(*),0) from snowflake.reader_account_usage.query_history
where USER_NAME = 'MANAGED_READER_ADMIN' and query_text ilike ('%NCIES%')) as actual
 , 1 as expected
 ,'03-00-01-09' as description
UNION ALL
SELECT 
  'SMEW10' as step
 ,(select count(*)/NULLIF(count(*),0) from snowflake.reader_account_usage.query_history
where USER_NAME = 'MANAGED_READER_ADMIN' and query_text ilike ('%IMPLE%')) as actual
 , 1 as expected
 ,'03-00-01-10' as description
UNION ALL 
SELECT 
    'SMEW11' as step 
,(select count(*)/NULLIF(count(*),0) from snowflake.reader_account_usage.query_history
where USER_NAME = 'MANAGED_READER_ADMIN' and query_text ilike ('%DE_TO%')) as actual
, 1 as expected
,'03-00-01-11' as description
); 
