# docker-alertmanager-webhook-servicenow

alertmanager-webhook-servicenow in a container

## Usage
### TL;DR
```
docker run \
  -v <PATH-TO-CONFIG>:/data/configuration.yaml \
  -e AWSN_SERVICE_NOW_INSTANCE_NAME="servicenow.example.com" \
  -e AWSN_SERVICE_NOW_USER_NAME="example" \
  -e AWSN_SERVICE_NOW_PASSWORD="example" \
  -p <PORT>:9876 \
  fxinnovation/awsn:<TAG>
```
