#!/bin/bash
set -e

echo "Installing SonarScanner for .NET..."
dotnet tool install --global dotnet-sonarscanner || true
export PATH="$PATH:$HOME/.dotnet/tools"

echo "Starting Sonar analysis..."

dotnet sonarscanner begin \
  /k:"AnjaliSingh0310_gitrepo" \
  /o:"anjalisingh0310" \
  /d:sonar.exclusions=**/TSDB/** \
  /d:sonar.host.url="https://sonarcloud.io" \
  /d:sonar.login=33f49840787e6388b6ceab0e11da146d09902636 \
  /d:sonar.cs.opencover.reportsPaths="**/coverage.opencover.xml"

# -------- JAVA BUILD --------
echo "Building Java project..."
cd simple-maven-project
mvn clean verify
cd ..

# -------- DOTNET BUILD --------
echo "Building .NET project..."
cd eShop-main
dotnet restore
dotnet build --no-restore

# Run tests with coverage
dotnet test \
  --no-build \
  /p:CollectCoverage=true \
  /p:CoverletOutputFormat=opencover
cd ..

# End Sonar analysis
dotnet sonarscanner end \
  /d:sonar.login="33f49840787e6388b6ceab0e11da146d09902636"

echo "Sonar analysis completed."
