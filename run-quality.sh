#!/bin/bash

echo "Starting Sonar Scan..."

sonar-scanner \
  -Dsonar.projectKey=anjalisingh0310_gitrepo \
  -Dsonar.organization=anjalisingh0310 \
  -Dsonar.exclusions=**/TSDB/** \
  -Dsonar.sources=. \
  -Dsonar.host.url=https://sonarcloud.io \
  -Dsonar.login=$SONAR_TOKEN 

echo "Sonar Scan Completed"
