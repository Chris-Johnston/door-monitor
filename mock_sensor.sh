#!/usr/bin/env bash

curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"cause": 0, "sensors": [{ "name": "TEST", "state": false }]}' \
  http://localhost:8088/api/sensor
