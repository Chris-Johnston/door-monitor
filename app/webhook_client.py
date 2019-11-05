import requests
import json
from database import get_db


def get_webhooks():
    with get_db() as DB:
        cur = DB.cursor()
        cur.execute(
            """
            SELECT
            type,
            endpointUrl,
            authorizationHeader
            FROM webhooks
            WHERE enabled
            """
        )
        output = []
        for result in cur.fetchall():
            output.append(
                {
                    "type": result[0],
                    "endpointUrl": result[1],
                    "authorizationHeader": result[2]
                }
            )
    return output


def notify_homeassistant(sensor_values, endpoint_data):
    # TODO: set up proper logging
    print("notifying HA")
    # create payload in the way HA wants
    payload = {
        "state": sensor_values[3],
        "attributes": {
            "friendly_name": sensor_values[0],
            "cause": sensor_values[4],
        }
    }
    response = requests.post(
        endpoint_data["endpointUrl"].format(sensor_values[0]),
        headers={
            "Authorization": endpoint_data["authorizationHeader"],
            "content-type": "application/json",
        },
        data=json.dumps(payload)
    )
    print("response", response)


def notify_discord(sensor_values, endpoint_data):
    if sensor_values[2] in [3, 4, 100, 101] and not sensor_values[1]:
        return

    print("notifying discord")
    payload = {
        "content": f"sensor {sensor_values[0]} updated to state {sensor_values[3]} reason {sensor_values[4]}",
    }
    response = requests.post(
        endpoint_data["endpointUrl"],
        headers={
            "Content-Type": "application/json"
        },
        data=json.dumps(payload)
    )
    print("response", response, response.text)


def notify_webhooks(sensor_values):
    """
    Notifies webhooks with the sensor values received.
    """
    print("notifying webhooks with data: ", sensor_values)
    endpoints = get_webhooks()
    for endpoint in endpoints:
        try:
            if endpoint["type"] == "homeassistant":
                notify_homeassistant(sensor_values, endpoint)
            elif endpoint["type"] == "discord":
                notify_discord(sensor_values, endpoint)
        except Exception as ex:
            print(f"Error when notifying webhook {endpoint['type']}", ex)