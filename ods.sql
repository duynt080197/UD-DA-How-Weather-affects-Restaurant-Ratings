/*create schema ODS*/
create schema ODS;
use schema ODS;

/*create 8 tables*/
drop table if exists PROJECT2_DATABASE.ODS.business;
create table PROJECT2_DATABASE.ODS.business
(business_id STRING PRIMARY KEY,
name STRING,
address STRING,
city STRING,
state STRING,
postal_code STRING,
latitude FLOAT,
longtitude FLOAT,
stars DOUBLE,
review_count INTEGER,
is_open INTEGER,
attributes VARIANT,
hours VARIANT);

drop table if exists PROJECT2_DATABASE.ODS.user;
create table PROJECT2_DATABASE.ODS.user(
    user_id STRING PRIMARY KEY,
    name STRING,
    review_count INTEGER,
    yelping_since STRING,
    useful INTEGER,
    funny INTEGER,
    cool INTEGER,
    elite VARIANT,
    friends VARIANT,
    fans INTEGER,
    average_stars DOUBLE,
    compliment_hot INTEGER,
    compliment_more INTEGER,
    compliment_profile INTEGER,
    compliment_cute INTEGER,
    compliment_list INTEGER,
    compliment_note INTEGER,
    compliment_plain INTEGER,
    compliment_cool INTEGER,
    compliment_funny INTEGER,
    compliment_writer INTEGER,
    compliment_photos INTEGER);

drop table if exists PROJECT2_DATABASE.ODS.checkin;
create table PROJECT2_DATABASE.ODS.checkin(
    checkin_id INT autoincrement,
    business_id STRING PRIMARY KEY,
    date string);

drop table if exists PROJECT2_DATABASE.ODS.review;
create table PROJECT2_DATABASE.ODS.review(
    review_id STRING PRIMARY KEY,
    user_id STRING FOREIGN KEY REFERENCES user(user_id),
    business_id STRING FOREIGN KEY REFERENCES business(business_id),
    stars DOUBLE,
    useful INTEGER,
    funny INTEGER,
    cool INTEGER,
    text STRING,
    date DATE);

drop table if exists PROJECT2_DATABASE.ODS.tip;
create table PROJECT2_DATABASE.ODS.tip(
    tip_id INT autoincrement PRIMARY KEY,
    user_id STRING FOREIGN KEY REFERENCES user(user_id),
    business_id STRING FOREIGN KEY REFERENCES business(business_id),
    text STRING,
    date DATE,
    compliment_count INTEGER);

drop table if exists PROJECT2_DATABASE.ODS.covid19;
create table PROJECT2_DATABASE.ODS.covid19(
    covid_id int autoincrement,
    business_id STRING PRIMARY KEY,
    highlights STRING,
    delivery_or_takeout STRING,
    grubhub_enabled STRING,
    call_to_action_enabled STRING,
    request_a_quote_enabled STRING,
    covid_banner STRING,
    temporary_closed_until STRING,
    virtual_servies_offered STRING);


DROP table if exists PROJECT2_DATABASE.ODS.temperature;
create table PROJECT2_DATABASE.ODS.temperature(
    date DATE PRIMARY KEY,
    max FLOAT,
    min FLOAT,
    normal_max FLOAT,
    normal_min FLOAT
);


DROP table if exists PROJECT2_DATABASE.ODS.precipitation;
create table PROJECT2_DATABASE.ODS.precipitation(
    date DATE PRIMARY KEY,
    precipitation string,
    precipitation_normal FLOAT
);


/*insert from tables in staging into tables in ods*/
insert into PROJECT2_DATABASE.ODS.business
SELECT
    $1:business_id::string,
    $1:name::string,
    $1:address::string,
    $1:city::string,
    $1:state::string,
    $1:postal_code::string,
    $1:latitude::float,
    $1:longitude::float,
    $1:stars::double,
    $1:review_count::integer,
    $1:is_open::integer,
    $1:attributes::variant,
    $1:hours::variant
    FROM PROJECT2_DATABASE.STAGING.business;

insert into PROJECT2_DATABASE.ODS.checkin(business_id, date)
SELECT
    $1:business_id::string,
    $1:date::string
    from PROJECT2_DATABASE.STAGING.checkin;

insert into PROJECT2_DATABASE.ODS.review
SELECT
    $1:review_id::string,
    $1:user_id::string,
    $1:business_id::string,
    $1:stars::double,
    $1:useful::int,
    $1:funny::integer,
    $1:cool::integer,
    $1:text::string,
    $1:date::date
    from PROJECT2_DATABASE.STAGING.review;

insert into PROJECT2_DATABASE.ODS.tip(user_id, business_id, text, date, compliment_count)
SELECT
    $1:user_id::string,
    $1:business_id::string,
    $1:text::string,
    $1:date::datetime,
    $1:compliment_count::integer
    from PROJECT2_DATABASE.STAGING.tip;

insert into PROJECT2_DATABASE.ODS.user
SELECT
    $1:user_id::string,
    $1:name::string,
    $1:review_count::integer,
    $1:yelping_since::string,
    $1:useful::integer,
    $1:funny::integer,
    $1:cool::integer,
    $1:elite::variant,
    $1:friends::variant,
    $1:fans::integer,
    $1:average_stars::Double,
    $1:compliment_hot::integer,
    $1:compliment_more::integer,
    $1:compliment_profile::integer,
    $1:compliment_cute::integer,
    $1:compliment_list::integer,
    $1:compliment_note::integer,
    $1:compliment_plain::integer,
    $1:compliment_cool::integer,
    $1:compliment_funny::integer,
    $1:compliment_writer::integer,
    $1:compliment_photos::integer
    from PROJECT2_DATABASE.Staging.user;

insert into PROJECT2_DATABASE.ODS.covid19(business_id, highlights, delivery_or_takeout, grubhub_enabled,
    call_to_action_enabled, request_a_quote_enabled, covid_banner, temporary_closed_until, virtual_servies_offered)
select
    $1:business_id::string,
    $1:highlights::string,
    $1:delivery_or_takeout::string,
    $1:grubhub_enabled::string,
    $1:call_to_action_enabled::string,
    $1:request_a_quote_enabled::string,
    $1:covid_banner::string,
    $1:temporary_closed_until::string,
    $1:virtual_servies_offered::string
    from PROJECT2_DATABASE.STAGING.covid19;

insert into PROJECT2_DATABASE.ODS.precipitation
select 
    to_date(date, 'YYYYMMDD'),
    precipitation,
    precipitation_normal
    from PROJECT2_DATABASE.STAGING.precipitation;

insert into PROJECT2_DATABASE.ODS.temperature
select
    to_date(date, 'YYYYMMDD'),
    max,
    min,
    normal_max,
    normal_min
    from PROJECT2_DATABASE.STAGING.temperature;
