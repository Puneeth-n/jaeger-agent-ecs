#!/bin/bash

getMetaData() {
  local res
  local body
  local status

  res=$(curl -m 1 --silent --write-out "HTTPSTATUS:%{http_code}" -X GET "$1")
  body=$(echo $res | sed -e 's/HTTPSTATUS\:.*//g')
  status=$(echo $res | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')

  if [ "$status" != "200" ]; then
    echo ""
  else
    echo "$body"
  fi

}

main() {
  ECS_HOST=$(getMetaData http://169.254.169.254/latest/meta-data/local-ipv4)

  export ECS_HOST
}

# entrypoint
main

exec /opt/agent/agent-linux --collector.host-port=$ECS_HOST:14267 "$@"

