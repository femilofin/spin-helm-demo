#!/bin/bash

set -ex

# package chart
helm package chart/spin-helm-demo

# push chart to git
setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

upload_chart() {
  git clone git://${CHART_REPO}

  # check if chart exist
  new_chart=`ls *.tgz`
  if [ -f helm-charts/$new_chart ]; then
    exit 0
  fi

  cp *.tgz helm-charts
  cd helm-charts
  git remote
  git add *.tgz
  git commit --message "Chart from travis build - $TRAVIS_BUILD_NUMBER"
  git push --force "https://${GH_TOKEN}@${CHART_REPO}" master > /dev/null 2>&1
}

setup_git
upload_chart

# trigger spinnaker pipeline
./scripts/trigger-pipeline.sh
