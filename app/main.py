from flask import Flask, request
app = Flask(__name__)

import sensor

@app.route("/", methods = ["GET", "POST"])
def test():
    print(request.data)
    return "test"

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True, port=8080)