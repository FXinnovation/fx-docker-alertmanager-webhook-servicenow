# docker-alertmanager-webhook-servicenow

alertmanager-webhook-servicenow in a container

## Usage
### TL;DR
```
docker run \
  -v <PATH-TO-CONFIG>:/data/configuration.yaml \
  -e AWSN_SERVICE_NOW_INSTANCE_NAME="instance_name" \
  -e AWSN_SERVICE_NOW_USER_NAME="example" \
  -e AWSN_SERVICE_NOW_PASSWORD="example" \
  -p <PORT>:9876 \
  fxinnovation/awsn:<TAG>
```

where `AWSN_SERVICE_NOW_INSTANCE_NAME` is the "instance_name" part of the ServiceNow URL (e.g.: https://instance_name.service-now.com)

### Format of config file
The YAML configuration file referenced by `<PATH-TO-CONFIG>` must have the following format

```
configuration: |-
  workflow:
    ...
  default_incident:
    ...
```

See [alertmanager-webhook-servicenow](https://github.com/FXinnovation/alertmanager-webhook-servicenow) for all available fields.