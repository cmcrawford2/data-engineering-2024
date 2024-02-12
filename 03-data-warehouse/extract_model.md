## Model deployment

[Tutorial](https://cloud.google.com/bigquery-ml/docs/export-model-tutorial)

### Steps

- gcloud auth login
- bq --project_id taxi-rides-ny extract -m nytaxi.tip_model gs://taxi_ml_model/tip_model
- mkdir /tmp/model
- gsutil cp -r gs://taxi_ml_model/tip_model /tmp/model
- mkdir -p serving_dir/tip_model/1
- cp -r /tmp/model/tip_model/\* serving_dir/tip_model/1
- docker pull tensorflow/serving
- docker run -p 8501:8501 --mount type=bind,source=`pwd`/serving_dir/tip_model,target=/models/tip_model -e MODEL_NAME=tip_model -t tensorflow/serving &
- curl -d '{"instances": [{"passenger_count":1, "trip_distance":12.2, "PULocationID":"193", "DOLocationID":"264", "payment_type":"2","fare_amount":20.4,"tolls_amount":0.0}]}' -X POST http://localhost:8501/v1/models/tip_model:predict
- http://localhost:8501/v1/models/tip_model

mkdir /tmp/model
gsutil cp -r gs://cris-crawfords-week3-bucket/tip_model /tmp/model
mkdir -p serving_dir/tip_model/1
cp -r /tmp/model/tip_model/\* serving_dir/tip_model/1
docker pull bitnami/tensorflow-serving:latest

docker run -p8500:8500 -p 8501:8501 --mount type=bind,source=`pwd`/serving_dir/tip_model,target=/bitnami/model-data -e MODEL_NAME=tip_model -t bitnami/tensorflow-serving &

curl -d '{"instances": [{"passenger_count":1, "trip_distance":12.2, "pu_location_id":"193", "do_location_id":"264", "payment_type":"2","fare_amount":20.4,"tolls_amount":0.0}]}' -X POST http://localhost:8501/v1/bitnami/model-data/tip_model:predict

http://localhost:8501/v1/model-data/tip_model

curl -d '{"instances": [{"passenger_count":1, "trip_distance":12.2, "pu_location_id":"193", "do_location_id":"264", "payment_type":"2","fare_amount":20.4,"tolls_amount":0.0}]}' -H "Content-Type: application/json" -X POST http://localhost:8501/v1/bitnami/model-data/tip_model:predict

curl -d '{"passenger_count":1, "trip_distance":12.2, "pu_location_id":"193", "do_location_id":"264", "payment_type":"2","fare_amount":20.4,"tolls_amount":0.0}' -H "Content-Type: application/json" -X POST http://localhost:8501/v1/bitnami/model-data/tip_model:predict
