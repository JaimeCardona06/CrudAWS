import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, PutCommand } from "@aws-sdk/lib-dynamodb";
import { randomUUID } from "crypto";


const ddbDocClient = DynamoDBDocumentClient.from(new DynamoDBClient({ region: "us-east-1" })); 

export const handler = async (event, context) => {
  try{
    const movie = JSON.parse(event.body);

    const newMovie = {
      ...movie,
      id: randomUUID()
    }

    await ddbDocClient.send(new PutCommand({
      TableName: "movies",
      Item: newMovie
    }));

    return{
      statusCode: 201,
      body: JSON.stringify(newMovie)
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