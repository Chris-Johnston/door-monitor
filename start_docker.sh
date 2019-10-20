echo Building image
docker build  -t sensormonitor_image .

echo Starting sensor montior
docker run -d --name sensormonitor -p 80:80 -v /app/database.db:/var/lib/sensor-monitor/database.db --restart always sensormonitor_image
