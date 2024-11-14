import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, ScanCommand } from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});

const dynamo = DynamoDBDocumentClient.from(client);

const tableName = "movies";

let body = "";

export const handler = async (event) => {
  try{

    body = await dynamo.send(new ScanCommand({
      TableName: tableName
    }));

    const response = body.Items;

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