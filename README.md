# CakePHP + Grafana Loki demo application

A demo application to send [CakePHP](https://cakephp.org/) docker container logs to [Grafana Loki](https://grafana.com/logs/) via [Fluentd](https://www.fluentd.org/).

Here, I've used CakePHP application but any containzed application logging to stderr/stdout can work.

## Installation

```bash
git clone git@github.com:ishanvyas22/cakephp-loki-demo.git
cd ishanvyas22/cakephp-loki-demo
```

## Configuration

1. Copy fluentd config file:
    ```bash
    cp fluentd/conf/fluent.conf.example fluentd/conf/fluent.conf
    ```

    Once copied, replace `__GRAFANA_URL__`, `__GRAFANA_USERNAME__`, and `__GRAFANA_PASSWORD__` values in `<match>` section with your grafana instance details.

2. Start fluentd server:
    ```bash
    docker build -t cakephp-loki-fluentd ./fluentd
    docker run -it -p 24224:24224 -v $(pwd)/fluentd/conf:/fluentd/etc cakephp-loki-fluentd
    ```

    If above commands ran succesffuly, then fluentd agent is ready to accept logs.

3. Finally, start the application using below command:
    ```bash
    docker compose up -d --remove-orphans
    ```

Now navigate to http://localhost:8765/ to generate logs from your CakePHP app. All the logs will be seen in your Grafana Loki dashboard after 10-15 seconds.
