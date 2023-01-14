/*create schema DWH*/
create SCHEMA DWH;
use SCHEMA DWH;
/*create 7 tables by clone from ODS and fact tables*/
drop table if EXISTS PROJECT2_DATABASE.DWH.business;
CREATE TABLE business CLONE PROJECT2_DATABASE.ODS.business;

drop table if EXISTS PROJECT2_DATABASE.DWH.user;
CREATE TABLE user CLONE PROJECT2_DATABASE.ODS.user;

drop table if EXISTS PROJECT2_DATABASE.DWH.checkin;
CREATE TABLE checkin CLONE PROJECT2_DATABASE.ODS.checkin;

drop table if EXISTS PROJECT2_DATABASE.DWH.review;
CREATE TABLE review CLONE PROJECT2_DATABASE.ODS.review;

drop table if EXISTS PROJECT2_DATABASE.DWH.covid19;
CREATE TABLE covid19 CLONE PROJECT2_DATABASE.ODS.covid19;

drop table if EXISTS PROJECT2_DATABASE.DWH.daily_temp_pre;
CREATE TABLE daily_temp_pre as select t.date, t.min, t.max, t.normal_min, t.normal_max, p.precipitation, p.precipitation_normal
from PROJECT2_DATABASE.ODS.temperature as t
join PROJECT2_DATABASE.ODS.precipitation as p
on t.date = p.date;


drop table if EXISTS PROJECT2_DATABASE.DWH.temperature;
CREATE TABLE temperature CLONE PROJECT2_DATABASE.ODS.temperature;

drop table if EXISTS PROJECT2_DATABASE.DWH.fact_table;
CREATE table fact_table2 as select b.business_id, r.review_id, r.user_id, d.date
    from business as b
    join review as r
    on b.business_id = r.business_id
    join checkin as c
    on b.business_id = c.business_id
    join covid19 as co
    on b.business_id = co.business_id
    join user as u
    on u.user_id = r.user_id
    join daily_temp_pre as d
    on d.date = r.date;