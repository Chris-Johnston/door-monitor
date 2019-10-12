from flask import Flask, request
from sensor import sensor_page
app = Flask(__name__)
app.register_blueprint(sensor_page)

@app.route("/", methods = ["GET", "POST"])
def test():
    print(request.data)
    return "test"

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True, port=8080)