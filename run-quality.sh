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

dotnet sonarscanner begin \
  /k:AnjaliSingh0310_gitrepo \
  /o:anjalisingh0310 \
  /d:sonar.host.url="https://sonarcloud.io" \
  /d:sonar.login=33f49840787e6388b6ceab0e11da146d09902636 \
  /d:sonar.cs.cobertura.reportsPaths="**/coverage.cobertura.xml" \
  /d:sonar.coverage.jacoco.xmlReportPaths="**/jacoco.xml"

# ---------------------------------------
# Build & Test Java Projects (if present)
# ---------------------------------------
if [ -d simple-maven-project ]; then
  echo "Building Java project..."
  cd simple-maven-project
  mvn clean verify
  cd ..
fi

# ---------------------------------------
# Build & Test .NET (Using Solution Filter)
# ---------------------------------------
echo "Building .NET solution..."

dotnet restore eShopOnWeb/eShopOnWeb.sln
dotnet build eShopOnWeb/eShopOnWeb.sln --no-restore

# -------------------------------
# Run .NET tests with coverage
# -------------------------------
echo "Running tests with coverage..."

dotnet test eShop-main/eShop.Web.slnf \
  --no-build \
  --collect:"XPlat Code Coverage"

# Debug (optional but useful)
echo "Searching for coverage files..."
find . -name "coverage.cobertura.xml"

# ---------------------------------------
# End SonarCloud Analysis
# ---------------------------------------
echo "Finishing SonarCloud analysis..."

dotnet sonarscanner end \
  /d:sonar.login=33f49840787e6388b6ceab0e11da146d09902636

echo "======================================="
echo "Code Quality Analysis Completed"
echo "======================================="
