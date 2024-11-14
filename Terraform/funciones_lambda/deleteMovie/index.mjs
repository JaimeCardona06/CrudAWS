import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, DeleteCommand } from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});

const dynamo = DynamoDBDocumentClient.from(client);

const tableName = "movies";

let body = "";

export const handler = async (event) => {
  try{

    await dynamo.send(new DeleteCommand({
      TableName: tableName,
      Key: {
        id: event.pathParameters.id
      }
    }));

    body = `Deleted item ${event.pathParameters.id}`;

    return{
      statusCode: 200,
      body: JSON.stringify(body)
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