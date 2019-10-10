from flask import request
from main import app
import datetime

print("AAaa")

@app.route("/api/sensor/test")
def test_sensor():
    return "test"

@app.route("/api/sensor/<int:id>", methods = ["POST"])
def log_sensor(id: int):
    """
    Logs sensor data.
    """
    return request.json

@app.route("/api/sensor/<int:id>", methods = ["GET"])
def get_sensor(id: int):
    """
    Gets the last reported state of the sensor.
    """
    return {
        "id": id,
        "state": "Locked",
        "timestamp": datetime.datetime.now(),
    }

@app.route("/api/sensor/<int:id>/history", methods = ["GET"])
def get_sensor_history(id: int):
    return [
    {
        "id": id,
        "state": "Locked",
        "timestamp": datetime.datetime.now(),
    },
    {
        "id": id,
        "state": "Unlocked",
        "timestamp": datetime.datetime.now(),
    },{
        "id": id,
        "state": "Locked",
        "timestamp": datetime.datetime.now(),
    },
    {
        "id": id,
        "state": "Unlocked",
        "timestamp": datetime.datetime.now(),
    }
    ]