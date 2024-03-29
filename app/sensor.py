from flask import request, Blueprint, jsonify
import datetime
from database import get_db
from webhook_client import notify_webhooks

sensor_page = Blueprint('sensor_page', __name__)

state_mapping = {
    True: "open",
    False: "closed"
}

cause_mapping = {
    0: "Initial boot-up.",
    3: "Sensor state changed.",
    4: "Timer activated.",
    100: "Open sensor reverted to closed.",
    101: "interrupt"
}

@sensor_page.route("/api/sensor/test")
def test_sensor():
    return "test"

@sensor_page.route("/api/sensor", methods = ["POST"])
def log_sensor():
    """
    Logs sensor data.
    """
    with get_db() as DB:
        c = DB.cursor()
        cause = request.json["cause"]
        for sensor in request.json["sensors"]:
            name = sensor["name"]
            state_bool = sensor["state"]
            state = 1 if state_bool else 0

            values = (name, state, cause)
            c.execute("INSERT INTO log (name, state, cause) VALUES (?, ?, ?)", values)

            # TODO map the cause to a string
            notify_webhooks((name, state_bool, cause, state_mapping[state_bool], cause_mapping[cause]))
        DB.commit()

    return "Ok"

def get_sensors_internal():
    """
    Gets the last reported state of all sensors that have reported
    in the last week. (This ignores stale readings)
    """
    query = """
    SELECT  b.id, sensor_name, b.state, b.cause, b.timestamp
    FROM log a
    INNER JOIN (
        SELECT name as sensor_name,
            id,
            state,
            cause,
            timestamp
        FROM log
    ) b ON name = sensor_name
    WHERE DATE(b.timestamp, 'weekday 0', '-7 days')
    GROUP BY sensor_name
    """
    with get_db() as DB:
        c = DB.cursor()
        c.execute(query)
        results = c.fetchall()
        output = []
        for log_id, name, state, cause, timestamp in results:
            output.append({
            "id": log_id,
            "name": name,
            "state": state,
            "cause": cause,
            "timestamp": timestamp})
    return output

@sensor_page.route("/api/sensor", methods = ["GET"])
def get_sensors():
    return jsonify(get_sensors_internal())

@sensor_page.route("/api/sensor/<name>", methods = ["GET"])
def get_sensor(name: str):
    """
    Gets the last reported state of the sensor.
    """
    with get_db() as DB:
        c = DB.cursor()
        c.execute("""
            SELECT id, name, state, cause, timestamp FROM log 
            WHERE name = ?
            ORDER BY timestamp DESC
        """, (name, )
        )

        log_id, name, state, cause, timestamp = c.fetchone()
    return jsonify({
        "id": log_id,
        "name": name,
        "state": state,
        "cause": cause,
        "timestamp": timestamp
    })

def get_sensor_history_internal(name: str, any: bool):
    query = """
    SELECT id, name, state, cause, timestamp
    FROM log
    WHERE DATE(timestamp, 'weekday 0', '-7 days') AND (name = ? OR ?)
    ORDER BY timestamp DESC
    LIMIT 50
    """
    with get_db() as DB:
        c = DB.cursor()
        c.execute(query, (name, any))
        results = c.fetchall()
        output = []
        for log_id, name, state, cause, timestamp in results:
            output.append({
            "id": log_id,
            "name": name,
            "state": state,
            "cause": cause,
            "timestamp": timestamp})
    return output

@sensor_page.route("/api/sensor/history", methods = ["GET"])
def get_history():
    return jsonify(get_sensor_history_internal("", True))

@sensor_page.route("/api/sensor/<name>/history", methods = ["GET"])
def get_sensor_history(name: str):
    return jsonify(get_sensor_history_internal(name, False))