FROM ubuntu:latest
RUN apt-get update && apt-get install -y procps coreutils systemd
WORKDIR /app
COPY system_health_report.sh .
RUN chmod +x system_health_report.sh
CMD [ "./system_health_report.sh" ]