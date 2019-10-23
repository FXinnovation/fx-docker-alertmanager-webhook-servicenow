FROM golang:1.12 as builder

ENV ALERTMANAGER_WEBHOOK_SERVICENOW_VERSION="1.1.0"

WORKDIR /go/src/github.com/FXinnovation/alertmanager-webhook-servicenow

RUN git clone https://github.com/FXinnovation/alertmanager-webhook-servicenow.git . &&\
    git checkout ${ALERTMANAGER_WEBHOOK_SERVICENOW_VERSION} &&\
    make build

FROM ubuntu:18.04

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

ENV AWSN_SERVICE_NOW_INSTANCE_NAME="servicenow.example.com" \
    AWSN_SERVICE_NOW_USER_NAME="example" \
    AWSN_SERVICE_NOW_PASSWORD="example" \
    AWSN_CONFIGURATION_FILE="/data/configuration.yaml" \
    CA_CERTIFICATES_VERSION="20180409" \
    ALERTMANAGER_WEBHOOK_SERVICENOW_VERSION="1.1.0" \
    CONFD_VERSION="0.16.0"

COPY --from=builder /go/src/github.com/FXinnovation/alertmanager-webhook-servicenow/alertmanager-webhook-servicenow /alertmanager-webhook-servicenow

ADD ./resources /resources

RUN /resources/build && rm -rf /resources

USER awsn

EXPOSE 9876

WORKDIR /opt/alertmanager-webhook-servicenow

VOLUME /data

ENTRYPOINT [ "/entrypoint" ]

LABEL "maintainer"="cloudsquad@fxinnovation.com" \
      "org.label-schema.name"="alertmanager-webhook-servicenow" \
      "org.label-schema.base-image.name"="docker.io/library/ubuntu" \
      "org.label-schema.base-image.version"="18.04" \
      "org.label-schema.description"="alertmanager-webhook-servicenow in a container" \
      "org.label-schema.url"="https://github.com/FXinnovation/alertmanager-webhook-servicenow" \
      "org.label-schema.vcs-url"="https://github.com/FXinnovation/alertmanager-webhook-servicenow" \
      "org.label-schema.vendor"="FXinnovation" \
      "org.label-schema.schema-version"="1.0.0-rc.1" \
      "org.label-schema.applications.alertmanager-webhook-servicenow.version"=$ALERTMANAGER_WEBHOOK_SERVICENOW_VERSION \
      "org.label-schema.applications.ca-certificates.version"=$CA_CERTIFICATES_VERSION \
      "org.label-schema.vcs-ref"=$VCS_REF \
      "org.label-schema.version"=$VERSION \
      "org.label-schema.build-date"=$BUILD_DATE \
      "org.label-schema.usage"="Please see README.md"
