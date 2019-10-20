echo Building image
docker build  -t sensormonitor_image .

echo Starting sensor montior
docker run --name sensormonitor -p 8088:80 --mount dst=/app/data,src=sensormonitor_vol --rm sensormonitor_image
