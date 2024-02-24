import json
import boto3

# Get the service resource.
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('aws-crc')

def lambda_handler(event, context):
    # Get current view counts
    response = table.get_item(
        Key={
            'id': '1'
        }
    )
    item = response['Item']
    visitorCount = item['visitorCount']
    visitorCount += 1
    
    table.update_item(
        Key={
            'id': '1'
        },
        UpdateExpression='SET visitorCount = :val',
        ExpressionAttributeValues={
            ':val': visitorCount
        }
    )
    
    return {
        'visitorCount' : visitorCount
    }
