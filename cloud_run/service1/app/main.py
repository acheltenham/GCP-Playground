import requests
import json
from google.cloud import storage
from google.cloud import pubsub_v1
import pandas as pd


## A simple Cloud Run Job to pull events from their Events API and push to a Pub/Sub topic 

def get_logs():
    url = f"https://your_okta_instance.com/api/v1/logs?since=2017-10-01T00:00:00.000Z"

    payload={}
    headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'SSWS <okta_token>'
    }
    response = requests.request("GET", url, headers=headers, data=payload)
    raw_logs = response.content #.decode('utf-8')
    return raw_logs


def convert_to_data_frame(data):
    json_data = json.loads(data)
    df = pd.json_normalize(json_data)
    return df


def convert_to_json(data):
    json_data = json.loads(data)
    return json_data


def publish_to_topic(data):
    client = pubsub_v1.PublisherClient()
    topic_id = 'your_pub-sub_topic'
    project_id = 'your_lab_id'
    topic_path = client.topic_path(project_id, topic_id)
    
    json_data = convert_to_json(data)
    
    for event in json_data:
     # Publish the message to the topic
        byte_event = json.dumps(event).encode('utf-8')
        client.publish(topic_path, data=byte_event)



logs = get_logs()

logs_json = convert_to_json(logs)

publish_to_topic(logs)