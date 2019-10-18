import json
from flask import Flask, request, render_template
from sensor import sensor_page, get_sensors_internal, get_sensor_history_internal
from settings import settings_page
app = Flask(__name__)
app.register_blueprint(sensor_page)
app.register_blueprint(settings_page)

def get_timeline_data():
    sensor_history = get_sensor_history_internal("", True)

    name_keys = set()
    formatted = {}
    for entry in sensor_history:
        name = entry["name"]
        if name not in name_keys:
            name_keys.add(name)
        if name not in formatted:
            formatted[name] = []
        if entry["state"] == 1:
            formatted[name].append(
                {
                    "starting_time": int(entry["timestamp"].strftime("%s"))
                }
            )
    result = []
    for item in name_keys:
        result.append(
            {
                "label": item,
                "times": formatted[item]
            }
        )

    return json.dumps(result)

@app.route("/", methods = ["GET", "POST"])
def test():
    # get the latest sensor states
    sensor_states = get_sensors_internal()
    history_data = get_timeline_data()

    return render_template("index.html", sensor_states = sensor_states, history_data = history_data)

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True, port=8080)