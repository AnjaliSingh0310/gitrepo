#!/usr/bin/env bash

set -euo pipefail

# ----------------------------
# Default values
# ----------------------------
PROJECT_KEY=""
ORGANIZATION=""
HOST_URL="https://sonarcloud.io"
SOLUTION=""
COVERAGE_PATH=""
SONAR_TOKEN=""

# ----------------------------
# Parse arguments
# ----------------------------
while [[ $# -gt 0 ]]; do
  case $1 in
    --project-key)
      PROJECT_KEY="$2"
      shift 2
      ;;
    --org)
      ORGANIZATION="$2"
      shift 2
      ;;
    --host-url)
      HOST_URL="$2"
      shift 2
      ;;
    --solution)
      SOLUTION="$2"
      shift 2
      ;;
    --coverage-path)
      COVERAGE_PATH="$2"
      shift 2
      ;;
    --token)
      SONAR_TOKEN="$2"
      shift 2
      ;;
    *)
      echo "❌ Unknown parameter passed: $1"
      exit 1
      ;;
  esac
done

# ----------------------------
# Validate required parameters
# ----------------------------
if [[ -z "$PROJECT_KEY" || -z "$SOLUTION" || -z "$SONAR_TOKEN" ]]; then
  echo "❌ Missing required parameters"
  echo "Required:"
  echo "  --project-key"
  echo "  --solution"
  echo "  --token"
  exit 1
fi

echo "🚀 Starting Sonar analysis..."
echo "Project Key: $PROJECT_KEY"
echo "Organization: $ORGANIZATION"
echo "Solution: $SOLUTION"

# ----------------------------
# Install SonarScanner for .NET if not available
# ----------------------------
if ! command -v dotnet-sonarscanner &> /dev/null
then
  echo "🔧 Installing dotnet-sonarscanner..."
  dotnet tool install --global dotnet-sonarscanner
  export PATH="$PATH:$HOME/.dotnet/tools"
fi

# ----------------------------
# Begin Sonar Analysis
# ----------------------------
if [[ -n "$ORGANIZATION" ]]; then
  # SonarCloud
  dotnet sonarscanner begin \
    /k:"$PROJECT_KEY" \
    /o:"$ORGANIZATION" \
    /d:sonar.host.url="$HOST_URL" \
    /d:sonar.login="$SONAR_TOKEN" \
    /d:sonar.cs.opencover.reportsPaths="$COVERAGE_PATH"
else
  # SonarQube (self-hosted)
  dotnet sonarscanner begin \
    /k:"$PROJECT_KEY" \
    /d:sonar.host.url="$HOST_URL" \
    /d:sonar.login="$SONAR_TOKEN" \
    /d:sonar.cs.opencover.reportsPaths="$COVERAGE_PATH"
fi

# ----------------------------
# Build
# ----------------------------
echo "🏗️ Building solution..."
dotnet build "$SOLUTION" --configuration Release

# ----------------------------
# Run Tests with Coverage
# ----------------------------
echo "🧪 Running tests..."
dotnet test "$SOLUTION" \
  --configuration Release \
  --collect:"XPlat Code Coverage"

# ----------------------------
# End Sonar Analysis
# ----------------------------
echo "📤 Ending Sonar analysis..."
dotnet sonarscanner end \
  /d:sonar.login="$SONAR_TOKEN"

echo "✅ Quality analysis completed successfully."