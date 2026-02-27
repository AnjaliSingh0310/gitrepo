#!/bin/bash
set -e

echo "======================================="
echo "Starting Code Quality & Coverage Check"
echo "======================================="

# ---------------------------------------
# Install SonarScanner for .NET (if not already)
# ---------------------------------------
echo "Installing SonarScanner for .NET..."
dotnet tool install --global dotnet-sonarscanner || true
export PATH="$PATH:$HOME/.dotnet/tools"

# ---------------------------------------
# Start SonarCloud Analysis
# ---------------------------------------
echo "Starting SonarCloud analysis..."

# Go into solution directory
#cd eShopOnWeb

dotnet sonarscanner begin \
  /k:AnjaliSingh0310_gitrepo \
  /o:anjalisingh0310 \
  /d:sonar.host.url="https://sonarcloud.io" \
  /d:sonar.login=33f49840787e6388b6ceab0e11da146d09902636 \
  /d:sonar.projectBaseDir="eShopOnWeb" \
  /d:sonar.cs.cobertura.reportsPaths="TestResults/coverage.xml" 

# ---------------------------------------
# Build & Test .NET (Using Solution Filter)
# ---------------------------------------
echo "Building .NET solution..."

dotnet restore eShopOnWeb.sln
dotnet build eShopOnWeb.sln --no-restore

# -------------------------------
# Run .NET tests with coverage
# -------------------------------
echo "Running tests with coverage..."

dotnet test eShopOnWeb.sln \
  --no-build \
  /p:CollectCoverage=true \
  /p:CoverletOutputFormat=cobertura \
  /p:CoverletOutput=./TestResults/coverage.xml

# Debug (optional but useful)
echo "Searching for coverage files..."
find . -name "coverage.cobertura.xml"

# ---------------------------------------
# End SonarCloud Analysis
# ---------------------------------------
echo "Finishing SonarCloud analysis..."

#echo "Displaying coverage report snippets for debugging..."
#head -n 150 tests/UnitTests/TestResults/*/coverage.cobertura.xml
#echo "Coverage report snippet displayed"


dotnet sonarscanner end \
  /d:sonar.login=33f49840787e6388b6ceab0e11da146d09902636

echo "======================================="
echo "Code Quality Analysis Completed"
echo "======================================="
