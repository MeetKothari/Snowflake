use role accountadmin;

select util_db.public.grader(step, (actual = expected), actual, expected, description) as graded_results from
(SELECT 
 'DORA_IS_WORKING' as step
 ,(select 123 ) as actual
 ,123 as expected
 ,'Dora is working!' as description
); 

select current_account();

-- There is no need to edit this code, but db and schema are flexible and will not affect whether your badge is issued
create or replace external function util_db.public.greeting(
      email varchar
    , firstname varchar
    , middlename varchar
    , lastname varchar)
returns variant
api_integration = dora_api_integration
context_headers = (current_timestamp,current_account, current_statement)
as 'https://awy6hshxy4.execute-api.us-west-2.amazonaws.com/dev/edu_dora/greeting'
;

SHOW stages; list @ZENAS_ATHLEISURE_DB.PRODUCTS.UNI_KLAUS_ZMD;

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
 SELECT
 'DLKW01' as step
  ,( select count(*)  
      from ZENAS_ATHLEISURE_DB.INFORMATION_SCHEMA.STAGES 
      where stage_url ilike ('%/clothing%')
      or stage_url ilike ('%/zenas_metadata%')
      or stage_url like ('%/sneakers%')
   ) as actual
, 3 as expected
, 'Stages for Klaus bucket look good' as description
);

select $1
from @ZENAS_ATHLEISURE_DB.PRODUCTS.UNI_KLAUS_ZMD; 


select $1
from @uni_klaus_zmd/product_coordination_suggestions.txt
(file_format => zmd_file_format_1);

select $1
from @uni_klaus_zmd/product_coordination_suggestions.txt
(file_format => zmd_file_format_2);

create or replace file format zmd_file_format_3
FIELD_DELIMITER = '='
RECORD_DELIMITER = '^'; 

select $1, $2
from @uni_klaus_zmd/product_coordination_suggestions.txt
(file_format => zmd_file_format_3);


-- Once you've replaced zmd_file_format_1, use it to query the sweatsuit_sizes.txt file. 

-- create or replace file format zmd_file_format_1
-- RECORD_DELIMITER = ';';

-- select $1 as sizes_available
-- from @uni_klaus_zmd/sweatsuit_sizes.txt
-- (file_format => zmd_file_format_1 );

-- Rewrite zmd_file_format_2 to parse swt_product_line.txt

create or replace file format zmd_file_format_2
RECORD_DELIMITER = ';',  
FIELD_DELIMITER = '|',
TRIM_SPACE = True;

create or replace view zenas_athleisure_db.products.sweatsuit_sizes as 
select REPLACE($1, chr(13)||chr(10)) AS sizes_available
from @uni_klaus_zmd/swt_product_line.txt
(file_format => zmd_file_format_2);

select * from zenas_athleisure_db.products.sweatsuit_sizes

-- Did you see Row 19? It's caused by an extra CRLF at the end of the file. Add a WHERE clause to your SELECT to nix that row!


create or replace view zenas_athleisure_db.products.sweatsuit_sizes as 
select REPLACE($1, chr(13)||chr(10)) AS sizes_available
from @uni_klaus_zmd/sweatsuit_sizes.txt
(file_format => zmd_file_format_1)
where sizes_available <> '';

select * from zenas_athleisure_db.products.sweatsuit_sizes


-- REPLACE file format 2 so that the DELIMITERS are correct to process the sweatband data file. 
-- Remove leading spaces in the data with the TRIM_SPACE property. 
-- Remove CRLFs from the data (via your select statement).
-- If there are any weird, empty rows, remove them (also via the select statement).
-- Put a view on top of it to make it easy to query in the future! Name your view: 
-- zenas_athleisure_db.products.SWEATBAND_PRODUCT_LINE
-- Don't forget to NAME the columns in your Create View statement. 
-- You can see the names you should use for your columns in the screenshot. 

create or replace file format zmd_file_format_2
RECORD_DELIMITER = ';',  
FIELD_DELIMITER = '|',
TRIM_SPACE = True;

create or replace view zenas_athleisure_db.products.SWEATBAND_PRODUCT_LINE (product_code, headband_description, wristband_description)
as 
select REPLACE($1, chr(13)||chr(10)) AS $1, 
    $2, 
    $3
from @uni_klaus_zmd/swt_product_line.txt
(file_format => zmd_file_format_2);

select * from zenas_athleisure_db.products.SWEATBAND_PRODUCT_LINE

-- File format 3 is already working for the product coordination data set, since it doesn't have a lot going on. 
-- Remove CRLFs from the data (via your select statement).
-- If there are any weird, empty rows, remove them (also via the select statement).
-- Put a view on top of it to make it easy to query in the future! Name your view:  
-- zenas_athleisure_db.products.SWEATBAND_COORDINATION
-- Give your view columns nice names!  (see screenshot)

create or replace file format zmd_file_format_3
RECORD_DELIMITER = '^',  
FIELD_DELIMITER = '=',
TRIM_SPACE = True;

create or replace view zenas_athleisure_db.products.SWEATBAND_COORDINATION (product_code, has_matching_sweatsuit)
as 
select $1, $2
from @uni_klaus_zmd/product_coordination_suggestions.txt
(file_format => zmd_file_format_3);

select * from zenas_athleisure_db.products.SWEATBAND_COORDINATION

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
 SELECT
   'DLKW02' as step
   ,( select sum(tally) from
        (select count(*) as tally
        from ZENAS_ATHLEISURE_DB.PRODUCTS.SWEATBAND_PRODUCT_LINE
        where length(product_code) > 7 
        union
        select count(*) as tally
        from ZENAS_ATHLEISURE_DB.PRODUCTS.SWEATSUIT_SIZES
        where LEFT(sizes_available,2) = char(13)||char(10))     
     ) as actual
   ,0 as expected
   ,'Leave data where it lands.' as description
); 

select $1
from @uni_klaus_clothing/90s_tracksuit.png; 

select metadata$filename, COUNT(metadata$filename)
from @uni_klaus_clothing
group by metadata$filename
;

--Directory Tables
select * from directory(@uni_klaus_clothing);

-- Oh Yeah! We have to turn them on, first
alter stage uni_klaus_clothing 
set directory = (enable = true);

--Now?
select * from directory(@uni_klaus_clothing);

--Oh Yeah! Then we have to refresh the directory table!
alter stage uni_klaus_clothing refresh;

--Now?
select * from directory(@uni_klaus_clothing);

--testing UPPER and REPLACE functions on directory table
select UPPER(RELATIVE_PATH) as uppercase_filename
, REPLACE(uppercase_filename,'/') as no_slash_filename
, REPLACE(no_slash_filename,'_',' ') as no_underscores_filename
, REPLACE(no_underscores_filename,'.PNG') as just_words_filename
from directory(@uni_klaus_clothing);

-- Now, can you nest them all into a single column and name it "PRODUCT_NAME"? 

-- select (UPPER(RELATIVE_PATH) as uppercase_filename, 
--         REPLACE(uppercase_filename, '/') as no_slash_filename,
--         REPLACE(no_slash_filename,'_',' ') as no_underscores_filename, 
--         REPLACE(no_underscores_filename,'.PNG') as just_words_filename)
        
--         from directory(@uni_klaus_clothing);
        

--create an internal table for some sweat suit info
create or replace TABLE ZENAS_ATHLEISURE_DB.PRODUCTS.SWEATSUITS (
	COLOR_OR_STYLE VARCHAR(25),
	DIRECT_URL VARCHAR(200),
	PRICE NUMBER(5,2)
);

--fill the new table with some data
insert into  ZENAS_ATHLEISURE_DB.PRODUCTS.SWEATSUITS 
          (COLOR_OR_STYLE, DIRECT_URL, PRICE)
values
('90s', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/90s_tracksuit.png',500)
,('Burgundy', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/burgundy_sweatsuit.png',65)
,('Charcoal Grey', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/charcoal_grey_sweatsuit.png',65)
,('Forest Green', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/forest_green_sweatsuit.png',65)
,('Navy Blue', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/navy_blue_sweatsuit.png',65)
,('Orange', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/orange_sweatsuit.png',65)
,('Pink', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/pink_sweatsuit.png',65)
,('Purple', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/purple_sweatsuit.png',65)
,('Red', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/red_sweatsuit.png',65)
,('Royal Blue',	'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/royal_blue_sweatsuit.png',65)
,('Yellow', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/yellow_sweatsuit.png',65);

-- join the directory table and the new sweatsuits table

select color_or_style,
    direct_url,
    price,
    size as image_size,
    last_modified as image_last_modified
from sweatsuits s
join directory (@uni_klaus_clothing) d 
on charindex(d.relative_path, s.direct_url)>0

-- 3 way join - internal table, directory table, and view based on external data
select color_or_style
, direct_url
, price
, size as image_size
, last_modified as image_last_modified
, sizes_available
from sweatsuits 
join directory(@uni_klaus_clothing) 
on relative_path = SUBSTR(direct_url,54,50)
cross join sweatsuit_sizes;

-- Lay a view on top of the select above and call it catalog. 

create or replace view catalog 
as 
select color_or_style
, direct_url
, price
, size as image_size
, last_modified as image_last_modified
, sizes_available
from sweatsuits 
join directory(@uni_klaus_clothing) 
on relative_path = SUBSTR(direct_url,54,50)
cross join sweatsuit_sizes
where sizes_available <> '';

select * from catalog;

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
 SELECT
 'DLKW03' as step
 ,( select count(*) from ZENAS_ATHLEISURE_DB.PRODUCTS.CATALOG) as actual
 ,198 as expected
 ,'Cross-joined view exists' as description
); 


-- Add a table to map the sweat suits to the sweat band sets
create table ZENAS_ATHLEISURE_DB.PRODUCTS.UPSELL_MAPPING
(
SWEATSUIT_COLOR_OR_STYLE varchar(25)
,UPSELL_PRODUCT_CODE varchar(10)
);

--populate the upsell table
insert into ZENAS_ATHLEISURE_DB.PRODUCTS.UPSELL_MAPPING
(
SWEATSUIT_COLOR_OR_STYLE
,UPSELL_PRODUCT_CODE 
)
VALUES
('Charcoal Grey','SWT_GRY')
,('Forest Green','SWT_FGN')
,('Orange','SWT_ORG')
,('Pink', 'SWT_PNK')
,('Red','SWT_RED')
,('Yellow', 'SWT_YLW');


-- Zena needs a single view she can query for her website prototype
create view catalog_for_website as 
select color_or_style
,price
,direct_url
,size_list
,coalesce('BONUS: ' ||  headband_description || ' & ' || wristband_description, 'Consider White, Black or Grey Sweat Accessories')  as upsell_product_desc
from
(   select color_or_style, price, direct_url, image_last_modified,image_size
    ,listagg(sizes_available, ' | ') within group (order by sizes_available) as size_list
    from catalog
    group by color_or_style, price, direct_url, image_last_modified, image_size
) c
left join upsell_mapping u
on u.sweatsuit_color_or_style = c.color_or_style
left join sweatband_coordination sc
on sc.product_code = u.upsell_product_code
left join sweatband_product_line spl
on spl.product_code = sc.product_code
where price < 200 -- high priced items like vintage sweatsuits aren't a good fit for this website
and image_size < 1000000 -- large images need to be processed to a smaller size
;

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
SELECT
'DLKW04' as step
 ,( select count(*) 
  from zenas_athleisure_db.products.catalog_for_website 
  where upsell_product_desc like '%NUS:%') as actual
 ,6 as expected
 ,'Relentlessly resourceful' as description
); 


-- Next, you'll add two stages. 
-- Camila has loaded geospatial trail files to the two folders shown below. 
-- These folders are in the trails folder of the dlkw folder of the uni-lab-files-more bucket in the AWS West 2 region. 
-- Remember that s3 is very particular about upper and lower case.  



create or replace stage trails_geojson 
url = 's3://uni-lab-files-more/dlkw/trails/trails_geojson';

list @trails_geojson;


create or replace stage mels_smoothie_challenge_db.trails.trails_parquet 
url='s3://uni-lab-files-more/dlkw/trails/trails_parquet'

list @trails_parquet;


-- Create two files formats:
-- Name one FF_JSON and set the Type to JSON
-- Name the other FF_PARQUET and set the Type to PARQUET
-- Make sure they are in the TRAILS schema

create or replace file format FF_JSON
type = JSON;

create or replace file format FF_PARQUET
type = PARQUET;

-- querying 

select $1
from @trails_geojson
(file_format => FF_JSON);

select count($1)
from @trails_parquet
(file_format => FF_PARQUET);

-- select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
-- (
-- SELECT
-- 'DLKW05' as step
--  ,( select sum(tally)
--    from
--      (select count(*) as tally
--       from mels_smoothie_challenge_db.information_schema.stages 
--       union all
--       select count(*) as tally
--       from mels_smoothie_challenge_db.information_schema.file_formats)) as actual
--  ,4 as expected
--  ,'Camila\'s Trail Data is Ready to Query' as description
--  ); 

-- Write a more sophisticated query to parse the data into columns.
-- {   "elevation": 1.579900000000000e+03,   "latitude": -1.050083600000000e+02,   "longitude": 3.975430990000000e+01,   "sequence_1": 1,   "sequence_2": 3526,   "trail_name": "Cherry Creek Trail" }

-- my version 
select 
    $1: sequence_1 as sequence_1,
    $1: trail_name::varchar as trail_name,
    $1: elevation as elevation,
    $1: latitude::number(11,8) as latitude,
    $1: longitude::number(11,8) as longitude,
    $1: sequence_2 as sequence_2
from @trails_parquet
(file_format => FF_PARQUET);

-- provided version 

--Nicely formatted trail data
select 
 $1:sequence_1 as point_id,
 $1:trail_name::varchar as trail_name,
 $1:latitude::number(11,8) as lng, --remember we did a gut check on this data
 $1:longitude::number(11,8) as lat
from @trails_parquet
(file_format => ff_parquet)
order by point_id;

--  Create a View Called CHERRY_CREEK_TRAIL
-- Wrap the select statement in a CREATE VIEW.
-- Name it CHERRY_CREEK_TRAIL. 
-- Make sure it is in Mel's database, in his TRAILS schema.

create or replace view CHERRY_CREEK_TRAIL(point_id, trail_name, lng, lat) as 

select 
 $1:sequence_1 as point_id,
 $1:trail_name::varchar as trail_name,
 $1:latitude::number(11,8) as lng, --remember we did a gut check on this data
 $1:longitude::number(11,8) as lat
from @trails_parquet
(file_format => ff_parquet)
order by point_id;

select * from cherry_creek_trail;

--Using concatenate to prepare the data for plotting on a map
select top 100 
 lng||' '||lat as coord_pair
,'POINT('||coord_pair||')' as trail_point
from cherry_creek_trail;

--To add a column, we have to replace the entire view
--changes to the original are shown in red
create or replace view cherry_creek_trail as
select 
 $1:sequence_1 as point_id,
 $1:trail_name::varchar as trail_name,
 $1:latitude::number(11,8) as lng,
 $1:longitude::number(11,8) as lat,
 lng||' '||lat as coord_pair
from @trails_parquet
(file_format => ff_parquet)
order by point_id;

select 
'LINESTRING('||
listagg(coord_pair, ',') 
within group (order by point_id)
||')' as my_linestring
from cherry_creek_trail
where point_id <= 10
group by trail_name;

-- Run a select on the geoJSON Stage, using the JSON file format you created.

select $1 
from @trails_geojson
(file_format => FF_JSON);

select
$1:features[0]:properties:Name::string as feature_name
,$1:features[0]:geometry:coordinates::string as feature_coordinates
,$1:features[0]:geometry::string as geometry
,$1:features[0]:properties::string as feature_properties
,$1:crs:properties:name::string as specs
,$1 as whole_object
from @trails_geojson (file_format => ff_json);

-- Wrap the previous select statement in a CREATE VIEW statement.
-- Name it DENVER_AREA_TRAILS. 
-- Make sure it is in Mel's database, in his TRAILS schema.

create or replace view denver_area_trails as
select
$1:features[0]:properties:Name::string as feature_name
,$1:features[0]:geometry:coordinates::string as feature_coordinates
,$1:features[0]:geometry::string as geometry
,$1:features[0]:properties::string as feature_properties
,$1:crs:properties:name::string as specs
,$1 as whole_object
from @trails_geojson (file_format => ff_json);

select * from denver_area_trails;

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
SELECT
'DLKW06' as step
 ,( select count(*) as tally
      from mels_smoothie_challenge_db.information_schema.views 
      where table_name in ('CHERRY_CREEK_TRAIL','DENVER_AREA_TRAILS')) as actual
 ,2 as expected
 ,'Mel\'s views on the geospatial data from Camila' as description
 );

 --Remember this code? 
select 
'LINESTRING('||
listagg(coord_pair, ',') 
within group (order by point_id)
||')' as my_linestring
,st_length(TO_GEOGRAPHY(my_linestring)) as length_of_trail --this line is new! but it won't work!
from cherry_creek_trail
group by trail_name;



select
feature_name,
st_length(to_geography(geometry)) as trail_length --this line is new! but it won't work!
from denver_area_trails;

select * from denver_area_trails;
select * from cherry_creak_trail;

-- create or replace view denver_area_trails as
-- select
-- $1:features[0]:properties:Name::string as feature_name
-- ,$1:features[0]:geometry:coordinates::string as feature_coordinates
-- ,$1:features[0]:geometry::string as geometry
-- ,$1:features[0]:st_length(to_geography(geometry)) as trail_length
-- ,$1:features[0]:properties::string as feature_properties
-- ,$1:crs:properties:name::string as specs
-- ,$1 as whole_object
-- from @trails_geojson (file_format => ff_json);

select * from denver_area_trails;

create or replace view DENVER_AREA_TRAILS( FEATURE_NAME, FEATURE_COORDINATES, GEOMETRY, TRAIL_LENGTH, FEATURE_PROPERTIES, SPECS, WHOLE_OBJECT ) as 
select 
$1:features[0]:properties:Name::string as feature_name 
,$1:features[0]:geometry:coordinates::string as feature_coordinates 
,$1:features[0]:geometry::string as geometry
,st_length(to_geography(geometry)) as trail_length
,$1:features[0]:properties::string as feature_properties 
,$1:crs:properties:name::string as specs 
,$1 as whole_object from @trails_geojson (file_format => ff_json);

select * from denver_area_trails;

--Create a view that will have similar columns to DENVER_AREA_TRAILS 
--Even though this data started out as Parquet, and we're joining it with geoJSON data
--So let's make it look like geoJSON instead.
create view DENVER_AREA_TRAILS_2 as
select 
trail_name as feature_name
,'{"coordinates":['||listagg('['||lng||','||lat||']',',')||'],"type":"LineString"}' as geometry
,st_length(to_geography(geometry)) as trail_length
from cherry_creek_trail
group by trail_name;

--Create a view that will have similar columns to DENVER_AREA_TRAILS 
select feature_name, geometry, trail_length
from DENVER_AREA_TRAILS
union all
select feature_name, geometry, trail_length
from DENVER_AREA_TRAILS_2;

--Add more GeoSpatial Calculations to get more GeoSpecial Information! 
create or replace view TRAILS_AND_BOUNDARIES as
select feature_name
, to_geography(geometry) as my_linestring
, st_xmin(my_linestring) as min_eastwest
, st_xmax(my_linestring) as max_eastwest
, st_ymin(my_linestring) as min_northsouth
, st_ymax(my_linestring) as max_northsouth
, trail_length
from DENVER_AREA_TRAILS
union all
select feature_name
, to_geography(geometry) as my_linestring
, st_xmin(my_linestring) as min_eastwest
, st_xmax(my_linestring) as max_eastwest
, st_ymin(my_linestring) as min_northsouth
, st_ymax(my_linestring) as max_northsouth
, trail_length
from DENVER_AREA_TRAILS_2;


select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
 SELECT
  'DLKW07' as step
   ,( select round(max(max_northsouth))
      from MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.TRAILS_AND_BOUNDARIES)
      as actual
 ,40 as expected
 ,'Trails Northern Extent' as description
 ); 

CREATE OR REPLACE FUNCTION distance_to_mc(loc_lat number(38,32), loc_lng number(38,32))
  RETURNS FLOAT
  AS
  $$
   st_distance(
        st_makepoint('-104.97300245114094','39.76471253574085')
        ,st_makepoint(loc_lat,loc_lng)
        )
  $$
  ;

  --Tivoli Center into the variables 
set tc_lat='-105.00532059763648'; 
set tc_lng='39.74548137398218';

select distance_to_mc($tc_lat,$tc_lng);

ALTER DATABASE OPENSTREETMAP_DENVER RENAME TO SONRA_DENVER_CO_USA_FREE;

create or replace view competition as 
select * 
from SONRA_DENVER_CO_USA_FREE.DENVER.V_OSM_DEN_AMENITY_SUSTENANCE
where 
    ((amenity in ('fast_food','cafe','restaurant','juice_bar'))
    and 
    (name ilike '%jamba%' or name ilike '%juice%'
     or name ilike '%superfruit%'))
 or 
    (cuisine like '%smoothie%' or cuisine like '%juice%');

select * from competition;

SELECT
 name
 ,cuisine
 , ST_DISTANCE(
    st_makepoint('-104.97300245114094','39.76471253574085')
    , coordinates
  ) AS distance_from_melanies
 ,*
FROM  competition
ORDER by distance_from_melanies;

SELECT
 name
 ,cuisine
 ,distance_to_mc(coordinates) AS distance_from_melanies
 ,*
FROM  competition
ORDER by distance_from_melanies;


CREATE OR REPLACE FUNCTION distance_to_mc(lat_and_lng GEOGRAPHY)
  RETURNS FLOAT
  AS
  $$
   st_distance(
        st_makepoint('-104.97300245114094','39.76471253574085')
        ,lat_and_lng
        )
  $$
  ;

-- Tattered Cover Bookstore McGregor Square
set tcb_lat='-104.9956203'; 
set tcb_lng='39.754874';

--this will run the first version of the UDF
select distance_to_mc($tcb_lat,$tcb_lng);

--this will run the second version of the UDF, bc it converts the coords 
--to a geography object before passing them into the function
select distance_to_mc(st_makepoint($tcb_lat,$tcb_lng));

--this will run the second version bc the Sonra Coordinates column
-- contains geography objects already
select name
, distance_to_mc(coordinates) as distance_to_melanies 
, ST_ASWKT(coordinates)
from SONRA_DENVER_CO_USA_FREE.DENVER.V_OSM_DEN_SHOP
where shop='books' 
and name like '%Tattered Cover%'
and addr_street like '%Wazee%';

-- Create a view that pulls all the bike shops in Denver into a view called DENVER_BIKE_SHOPS. 
-- Make sure the view is in the LOCATIONS schema and is owned by SYSADMIN. 

-- There are 33 bike shops in the data set right now. (This may vary over time but should not vary by a LOT.)
-- You can find the shops in either the V_OSM_DEN_SHOP_OUTDOORS_AND_SPORT_VEHICLES or the V_OSM_DEN_SHOP table. The benefit of using the more specific view is that the columns included are more directly related to a bike shop. 
-- You can use a WHERE <column> = 'bicycle' -- you just have to figure out which column. 
-- Be sure to include a column called DISTANCE_TO_MELANIES that calculates the distance to Melanie's Café for each Bike Shop

create or replace view DENVER_BIKE_SHOPS(name, distance_to_melanies)
as 
select name,
distance_to_mc(coordinates) as distance_to_melanies
from sonra_denver_co_usa_free.denver.v_osm_den_shop_outdoors_and_sport_vehicles
where shop = 'bicycle';

select * from denver_bike_shops;
select * from sonra_denver_co_usa_free.denver.v_osm_den_shop_outdoors_and_sport_vehicles;

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
  SELECT
  'DLKW08' as step
  ,( select truncate(distance_to_melanies)
      from mels_smoothie_challenge_db.locations.denver_bike_shops
      where name like '%Mojo%') as actual
  ,14084 as expected
  ,'Bike Shop View Distance Calc works' as description
 ); 

 create or replace external table T_CHERRY_CREEK_TRAIL(
	my_filename varchar(50) as (metadata$filename::varchar(50))
) 
location= @trails_parquet
auto_refresh = true
file_format = (type = parquet);

select get_ddl('view','mels_smoothie_challenge_db.trails.cherry_creek_trail');

create or replace external table mels_smoothie_challenge_db.trails.T_CHERRY_CREEK_TRAIL(
	POINT_ID number as ($1:sequence_1::number),
	TRAIL_NAME varchar(50) as  ($1:trail_name::varchar),
	LNG number(11,8) as ($1:latitude::number(11,8)),
	LAT number(11,8) as ($1:longitude::number(11,8)),
	COORD_PAIR varchar(50) as (lng::varchar||' '||lat::varchar)
) 
location= @mels_smoothie_challenge_db.trails.trails_parquet
auto_refresh = true
file_format = mels_smoothie_challenge_db.trails.ff_parquet;

select * from t_cherry_creek_trail;

select * from cherry_creek_trail;
select get_ddl('view','cherry_creek_trail');

select * from smv_cherry_creek_trail;

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
  SELECT
  'DLKW09' as step
  ,( select row_count
     from mels_smoothie_challenge_db.information_schema.tables
     where table_schema = 'TRAILS'
    and table_name = 'SMV_CHERRY_CREEK_TRAIL')   
   as actual
  ,3526 as expected
  ,'Secure Materialized View Created' as description
 ); 





 




 







