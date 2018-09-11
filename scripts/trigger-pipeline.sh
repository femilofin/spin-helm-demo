#!/bin/bash

SPINNAKER_API=https://spinnaker.demo.armory.io/api/webhooks/webhook/spin-helm-demo
CHART_VERSION=`cat chart/spin-helm-demo/Chart.yaml | grep version | awk '{print $2}'`
CHART_NAME=`cat chart/spin-helm-demo/Chart.yaml | grep name | awk '{print $2}'`
CHART_GIT_API=`https://api.github.com/repos/femilofin/helm-charts/spin-helm-demo-${CHART_VERSION}.tgz`

curl -L -vvv -X POST \
		-k \
		-H"Content-Type: application/json" ${SPINNAKER_API} \
		-d '{"artifacts": [{"type": "github/file", "name": "${CHART_NAME}", "reference":
"${CHART_GIT_API}", "kind": "default.github"}]}'
