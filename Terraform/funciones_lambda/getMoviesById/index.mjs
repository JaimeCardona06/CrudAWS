import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, GetCommand } from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});

const dynamo = DynamoDBDocumentClient.from(client);

const tableName = "movies";

let body = "";

export const handler = async (event) => {
  try{

    body = await dynamo.send(new GetCommand({
      TableName: tableName,
      Key: {
        id: event.pathParameters.id
      }
    }));

    const response = body.Item;

    return{
      statusCode: 200,
      body: JSON.stringify(response)
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