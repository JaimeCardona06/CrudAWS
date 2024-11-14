import json
import boto3
import uuid

s3_client = boto3.client("s3")
dynamodb = boto3.resource("dynamodb")

table = dynamodb.Table("movies")

def lambda_handler(event, context):

    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    csv_file = s3_client.get_object(Bucket = bucket, Key = key)

    data = csv_file['Body'].read().decode('utf-8')

    movies = data.split("\n")
    
    movies.pop(0)

    for movie in movies:
        movie_data = movie.split(",")

        try:
            table.put_item(

                Item = {
                "id": str(uuid.uuid4()),
                "name": movie_data[1],
                "duration": movie_data[2],
                "revenue": movie_data[3],
                "release_date": movie_data[4]
                }
            )

        except Exception as e:
            print("Error: ", e)