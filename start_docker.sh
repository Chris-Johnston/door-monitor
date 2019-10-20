echo Building image
docker build  -t sensormonitor_image .

echo Starting sensor montior
docker run -d --name sensormonitor -p 80:80 --mount dst=/app/data,src=sensormonitor_vol --restart always sensormonitor_image
