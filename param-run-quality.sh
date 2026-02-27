#!/bin/bash
set -e

# ---------------------------------------
# Parse Named Parameters
# ---------------------------------------
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --project-key) PROJECT_KEY="$2"; shift ;;
    --org) ORG="$2"; shift ;;
    --host-url) HOST_URL="$2"; shift ;;
    --solution) SOLUTION_PATH="$2"; shift ;;
    --coverage-path) COVERAGE_PATH="$2"; shift ;;
    --token) SONAR_TOKEN="$2"; shift ;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

# ---------------------------------------
# Validate Required Parameters
# ---------------------------------------
if [[ -z "$PROJECT_KEY" || -z "$ORG" || -z "$HOST_URL" || -z "$SOLUTION_PATH" || -z "$COVERAGE_PATH" || -z "$SONAR_TOKEN" ]]; then
  echo "Missing required parameters."
  echo "Required:"
  echo "  --project-key"
  echo "  --org"
  echo "  --host-url"
  echo "  --solution"
  echo "  --coverage-path"
  echo "  --token"
  exit 1
fi

echo "======================================="
echo "Starting Code Quality & Coverage Check"
echo "======================================="

# ---------------------------------------
# Install SonarScanner for .NET
# ---------------------------------------
echo "Installing SonarScanner for .NET..."
dotnet tool install --global dotnet-sonarscanner || true
export PATH="$PATH:$HOME/.dotnet/tools"

# ---------------------------------------
# Start SonarCloud Analysis
# ---------------------------------------
echo "Starting SonarCloud analysis..."

dotnet sonarscanner begin \
  /k:"$PROJECT_KEY" \
  /o:"$ORG" \
  /d:sonar.host.url="$HOST_URL" \
  /d:sonar.token="$SONAR_TOKEN" \
  /d:sonar.cs.cobertura.reportsPaths="$COVERAGE_PATH"

# ---------------------------------------
# Build
# ---------------------------------------
echo "Restoring solution..."
dotnet restore "$SOLUTION_PATH"

echo "Building solution..."
dotnet build "$SOLUTION_PATH" --no-restore

# ---------------------------------------
# Test with Coverage
# ---------------------------------------
echo "Running tests with coverage..."
dotnet test "$SOLUTION_PATH" \
  --no-build \
  --collect:"XPlat Code Coverage"

echo "Searching for coverage files..."
find . -name "coverage.cobertura.xml"

# ---------------------------------------
# Debug Coverage Snippet (optional)
# ---------------------------------------
echo "Displaying coverage snippet (if exists)..."
find . -name "coverage.cobertura.xml" -exec head -n 50 {} \; || true

# ---------------------------------------
# End Sonar Analysis
# ---------------------------------------
echo "Finishing SonarCloud analysis..."

dotnet sonarscanner end \
  /d:sonar.token="$SONAR_TOKEN"

echo "======================================="
echo "Code Quality Analysis Completed"
echo "======================================="