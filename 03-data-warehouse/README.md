https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-01.parquet
https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-02.parquet

CREATE OR REPLACE EXTERNAL TABLE `data-engineering-2024-411821.ny_taxi.external_green_tripdata`
OPTIONS (
format = 'PARQUET',
uris = ['gs://cris-crawfords-week3-bucket/green_taxi_data/*.parquet']
);

SELECT count(\*)
FROM `ny_taxi.external_green_tripdata`;

CREATE OR REPLACE TABLE `data-engineering-2024-411821.ny_taxi.green_nonpartitioned_tripdata`
AS SELECT \* FROM `data-engineering-2024-411821.ny_taxi.external_green_tripdata`;

SELECT pu_location_id, COUNT(\*) AS location_count
FROM data-engineering-2024-411821.ny_taxi.green_nonpartitioned_tripdata
GROUP BY pu_location_id
ORDER BY pu_location_id;

SELECT count(\*)
FROM data-engineering-2024-411821.ny_taxi.green_nonpartitioned_tripdata
WHERE fare_amount = 0.0;

CREATE OR REPLACE TABLE `data-engineering-2024-411821.ny_taxi.green_partitioned_tripdata`
PARTITION BY DATE(lpep_dropoff_datetime)
CLUSTER BY pu_location_id AS (
SELECT \* FROM `data-engineering-2024-411821.ny_taxi.green_nonpartitioned_tripdata`
);

-- Write a query to retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 (inclusive)

SELECT DISTINCT pu_location_id
FROM data-engineering-2024-411821.ny_taxi.green_partitioned_tripdata
WHERE lpep_pickup_datetime > "2022-06-01 00:00:00" and lpep_pickup_datetime < "2022-06-30 23:59:59";
