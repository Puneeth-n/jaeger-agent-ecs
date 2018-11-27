FROM ubuntu:18.04

WORKDIR /opt/agent/
RUN apt-get update && apt-get install -y \
      curl && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["/launch.sh"]

COPY --from=jaegertracing/jaeger-agent:1.7 /go/bin/agent-linux agent-linux

COPY ./launch.sh /launch.sh
