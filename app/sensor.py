from flask import request, Blueprint, jsonify
import datetime
from database import DB

sensor_page = Blueprint('sensor_page', __name__)

@sensor_page.route("/api/sensor/test")
def test_sensor():
    return "test"

@sensor_page.route("/api/sensor", methods = ["POST"])
def log_sensor():
    """
    Logs sensor data.
    """
    c = DB.cursor()
    cause = request.json["cause"]
    for sensor in request.json["sensors"]:
        name = sensor["name"]
        state = 1 if sensor["state"] else 0

        values = (name, state, cause)
        c.execute("INSERT INTO log (name, state, cause) VALUES (?, ?, ?)", values)
    DB.commit()

    return "Ok"

@sensor_page.route("/api/sensor", methods = ["GET"])
def get_sensors():
    """
    Gets the last reported state of all sensors that have reported
    in the last week. (This ignores stale readings)
    """
    query = """
    SELECT sensor_name, b.id, b.state, b.cause, b.timestamp
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
    return jsonify(output)

@sensor_page.route("/api/sensor/<name>", methods = ["GET"])
def get_sensor(name: str):
    """
    Gets the last reported state of the sensor.
    """
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

@sensor_page.route("/api/sensor/<name>/history", methods = ["GET"])
def get_sensor_history(name: str):
    query = """
    SELECT id, name, state, cause, timestamp
    FROM log
    WHERE DATE(timestamp, 'weekday 0', '-7 days') AND name = ?
    ORDER BY timestamp DESC
    LIMIT 50
    """
    c = DB.cursor()
    c.execute(query, (name,))
    results = c.fetchall()
    output = []
    for log_id, name, state, cause, timestamp in results:
        output.append({
        "id": log_id,
        "name": name,
        "state": state,
        "cause": cause,
        "timestamp": timestamp})
    return jsonify(output)