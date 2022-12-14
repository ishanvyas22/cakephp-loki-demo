# CakePHP + Grafana Loki demo application

A demo application to send [CakePHP](https://cakephp.org/) docker container logs to [Grafana Loki](https://grafana.com/logs/) via [Fluentd](https://www.fluentd.org/).

![Default page screenshot](./screenshot.png)

Here, I've used CakePHP application but any containerized application logging to stderr/stdout can work.

## Requirements

- [Docker](https://docs.docker.com/get-docker/) v20 or newer
- Grafana Loki instance. **Recommended:** [Grafana Cloud](https://grafana.com/), it's free to play around.

## Installation

1. Clone project into your local system:
    ```bash
    git clone git@github.com:ishanvyas22/cakephp-loki-demo.git
    cd cakephp-loki-demo
    ```

1. Copy fluentd config file:
    ```bash
    cp fluentd/conf/fluent.conf.example fluentd/conf/fluent.conf
    ```

    Once copied, replace `__GRAFANA_URL__`, `__GRAFANA_USERNAME__`, and `__GRAFANA_PASSWORD__` values in `<match>` section with your grafana instance details.

1. Start fluentd server:
    ```bash
    docker build -t cakephp-loki-fluentd ./fluentd
    docker run -it -p 24224:24224 -v $(pwd)/fluentd/conf:/fluentd/etc cakephp-loki-fluentd
    ```

    If above commands run successfully, then fluentd agent is ready to accept logs. Make sure to keep this command running in background so it can gather and send logs to Loki.

1. Finally, start the application using below command:
    ```bash
    docker compose up -d --remove-orphans
    ```

Now navigate to http://localhost:8765/ to generate logs from your CakePHP app. All the logs will be seen in your Grafana Loki dashboard after 10-15 seconds.
