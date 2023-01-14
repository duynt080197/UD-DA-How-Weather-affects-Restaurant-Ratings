# Design a Data Warehouse for Reporting and OLAP

## Introduction to the Project
In this project scenario, I use actual YELP and climate datasets in order to analyze the effects the weather has on customer reviews of restaurants. The data for temperature and precipitation observations are from the Global Historical Climatology Network-Daily (GHCN-D) database. I use a leading industry cloud-native data warehouse system called Snowflake for all aspects of the project.

I architect and design a Data Warehouse DWH for the purpose of reporting and online analytical processing (OLAP).

## Data sources
In this project, you will merge two massive, real-world datasets in order to draw conclusions about how weather affects Yelp reviews.

The first step is to obtain the data we will use for the project.
- the COVID-19 dataset
- the climate data from Climate Explorer web

## Step by Step
Create a data architecture diagram to visualize how you will ingest and migrate the data into Staging, Operational Data Store (ODS), and Data Warehouse environments, so as to ultimately query the data for relationships between weather and Yelp reviews. Save this so it can be included in your final submission.
Create a staging environment(schema) in Snowflake.
Upload all Yelp and Climate data to the staging environment. (Screenshots 1,2) (see Screenshot description below)
NOTE: You may need to SPLIT these datasets into several smaller files (< 3 million records per file in YELP)
Create an ODS environment(aka schema).
Draw an entity-relationship (ER) diagram to visualize the data structure. Save this so it can be included in your final submission.
Migrate the data into the ODS environment. (Screenshots 3,4,5,6)
Draw a STAR schema for the Data Warehouse environment. Save this so it can be included in your final submission.
Migrate the data to the Data Warehouse. (Screenshot 7)
Query the Data Warehouse to determine how weather affects Yelp reviews. ( Screenshot 8)

## Diagrams
### Data Diagram
![diagram_project2](https://user-images.githubusercontent.com/73277412/212471410-9e9efff5-bc4d-4cac-94d1-66f1a1dc6a1d.png)
### ER diagram
![ER](https://user-images.githubusercontent.com/73277412/212471426-b31869f9-0f0d-43cd-8af7-b021c2cc5c77.png)
### STAR Schema
![STAR](https://user-images.githubusercontent.com/73277412/212471482-ce67477a-6f15-4bc9-8995-1aa4d3d6124a.png)
