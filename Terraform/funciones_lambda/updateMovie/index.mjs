import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, PutCommand } from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});

const dynamo = DynamoDBDocumentClient.from(client);

const tableName = "movies";

let body = "";

export const handler = async (event) => {
  try{

    let requestJSON = JSON.parse(event.body);

    await dynamo.send(new PutCommand({
      TableName: tableName,
      Item: {
        id: requestJSON.id,
        name: requestJSON.name,
        duration: requestJSON.duration,
        revenue: requestJSON.revenue,
        release_date: requestJSON.release_date
      }
    }));

    return{
      statusCode: 200,
      body: JSON.stringify({
        id: requestJSON.id,
        name: requestJSON.name,
        duration: requestJSON.duration,
        revenue: requestJSON.revenue,
        release_date: requestJSON.release_date
      })
    };
  }
  catch (error){
    console.error(error);
    return{
      statusCode: 500,
      body: JSON.stringify({ message: error.message })
    }
  }
};