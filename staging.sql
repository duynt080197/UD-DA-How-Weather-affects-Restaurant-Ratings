/*create warehouse*/
CREATE WAREHOUSE DUYNT71;
USE WAREHOUSE DUYNT71;

/* Create a database for project 2*/
CREATE DATABASE PROJECT2_DATABASE;
USE PROJECT2_DATABASE;

/*create staging schema*/
CREATE SCHEMA STAGING;
USE SCHEMA STAGING;

/*create 8 tables*/
DROP TABLE IF EXISTS PROJECT2_DATABASE.STAGING.business;
CREATE TABLE PROJECT2_DATABASE.STAGING.business(business variant);

DROP TABLE IF EXISTS PROJECT2_DATABASE.STAGING.user;
CREATE TABLE PROJECT2_DATABASE.STAGING.user(user variant);

DROP TABLE IF EXISTS PROJECT2_DATABASE.STAGING.review;
CREATE TABLE PROJECT2_DATABASE.STAGING.review(review variant);

DROP TABLE IF EXISTS PROJECT2_DATABASE.STAGING.tip;
CREATE TABLE PROJECT2_DATABASE.STAGING.tip(tip VARIANT);

DROP TABLE IF EXISTS PROJECT2_DATABASE.STAGING.checkin;
CREATE TABLE PROJECT2_DATABASE.STAGING.checkin(checkin variant);

DROP TABLE IF EXISTS PROJECT2_DATABASE.STAGING.covid19;
CREATE TABLE PROJECT2_DATABASE.STAGING.covid19(covid19 variant);

DROP TABLE IF EXISTS PROJECT2_DATABASE.STAGING.temperature;
CREATE TABLE PROJECT2_DATABASE.STAGING.temperature(
    date STRING,
    min FLOAT,
    max FLOAT,
    normal_min FLOAT,
    normal_max FLOAT
);

DROP TABLE IF EXISTS PROJECT2_DATABASE.STAGING.precipitation;
CREATE TABLE PROJECT2_DATABASE.STAGING.precipitation(
    date STRING,
    precipitation STRING,
    precipitation_normal FLOAT
);

/*create 2 file format*/
CREATE or REPLACE file format jsonformat type='JSON' strip_null_values=true compression='auto';
CREATE or REPLACE file format csvformat type='CSV' compression='auto' field_delimiter=',' record_delimiter='\n' skip_header=1 error_on_column_count_mismatch=true null_if = ('NULL', 'null') empty_field_as_null=true;
/*create 2 stages*/
create or replace stage duynt_json_stage file_format = jsonformat;
create or replace stage duynt_csv_stage file_format = csvformat;

/*put 8 files from local to stage in snowflake*/
put file://D:\udacity-project2/business.json @duynt_json_stage auto_compress = true parallel=10;
put file://D:\udacity-project2/user.json @duynt_json_stage auto_compress = true parallel=10;
put file://D:\udacity-project2/review.json @duynt_json_stage auto_compress = true parallel=10;
put file://D:\udacity-project2/tip.json @duynt_json_stage auto_compress=true parallel=10;
put file://D:\udacity-project2/checkin.json @duynt_json_stage auto_compress = true parallel=10;
put file://D:\udacity-project2/covid19.json @duynt_json_stage auto_compress = true parallel=10;
put file://D:\udacity-project2/temperature.csv @duynt_csv_stage auto_compress = true parallel=1;
put file://D:\udacity-project2/precipitation.csv @duynt_csv_stage auto_compress = true parallel=1;

/*copy 8 files from stage to 8 tables in STAGING schema*/
COPY INTO business FROM @duynt_json_stage/business.json;
COPY INTO user FROM @duynt_json_stage/user.json;
COPY INTO review FROM @duynt_json_stage/review.json;
COPY INTO tip FROM @duynt_json_stage/tip.json;
COPY INTO checkin FROM @duynt_json_stage/checkin.json;
COPY INTO covid19 FROM @duynt_json_stage/covid19.json;
COPY INTO temperature FROM 
(
    SELECT temp.$1,
           temp.$2,
           temp.$3,
           temp.$4,
           temp.$5
    FROM @duynt_csv_stage/temperature.csv.gz temp
);
COPY INTO precipitation FROM 
(
    SELECT pre.$1,
           pre.$2,
           pre.$3
    FROM @duynt_csv_stage/precipitation.csv.gz pre
);