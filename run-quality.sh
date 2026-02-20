#!/bin/bash

echo "Starting Sonar Scan..."

sonar-scanner \
  -Dsonar.projectKey=AnjaliSingh0310_gitrepo \
  -Dsonar.organization=anjalisingh0310 \
  -Dsonar.exclusions=**/TSDB/** \
  -Dsonar.sources=. \
  -Dsonar.host.url=https://sonarcloud.io \
  -Dsonar.login=33f49840787e6388b6ceab0e11da146d09902636 

echo "Sonar Scan Completed"
