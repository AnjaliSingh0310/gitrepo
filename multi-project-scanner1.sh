#!/bin/bash
set -e

########################################
# Parse Parameters
########################################
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --project-key-prefix) PREFIX="$2"; shift ;;
    --org) ORG="$2"; shift ;;
    --host-url) HOST_URL="$2"; shift ;;
    --token) SONAR_TOKEN="$2"; shift ;;
    *) echo "Unknown parameter $1"; exit 1 ;;
  esac
  shift
done

########################################
# Validate parameters
########################################
if [[ -z "$PREFIX" || -z "$HOST_URL" || -z "$SONAR_TOKEN" ]]; then
  echo "Missing required parameters"
  echo "Usage:"
  echo "./run-quality.sh --project-key-prefix repo --host-url http://sonar:9000 --token TOKEN"
  exit 1
fi

########################################
# Install SonarScanner
########################################
echo "Installing SonarScanner for .NET"

dotnet tool install --global dotnet-sonarscanner || true
export PATH="$PATH:$HOME/.dotnet/tools"

########################################
# Arrays for reporting
########################################
SCANNED_PROJECTS=()
SKIPPED_PROJECTS=()

########################################
# Function: detect supported frameworks
########################################
is_supported_project() {

  FILE=$1

  FRAMEWORK=$(grep -oPm1 "(?<=<TargetFramework>)[^<]+" "$FILE" || true)

  echo "Detected framework: $FRAMEWORK for project $FILE"

  if grep -qi "<UseMaui>" "$FILE"; then
      echo "Skipping MAUI project: $FILE"
      SKIPPED_PROJECTS+=("$FILE (MAUI)")
      return 1
  fi

  if [[ "$FRAMEWORK" == *android* ||
        "$FRAMEWORK" == *ios* ||
        "$FRAMEWORK" == *maccatalyst* ||
        "$FRAMEWORK" == *tizen* ]]; then

      echo "Skipping mobile workload project: $FILE ($FRAMEWORK)"
      SKIPPED_PROJECTS+=("$FILE ($FRAMEWORK)")
      return 1
  fi

  return 0
}

########################################
# Detect projects
########################################
echo "Searching for .NET projects..."

PROJECTS=$(find . -name "*.csproj")

if [[ -z "$PROJECTS" ]]; then
  echo "No .NET projects found"
  exit 1
fi

########################################
# Scan projects
########################################
for PROJ in $PROJECTS
do
echo "---------------------------------------"
echo "Scanning project file: $PROJ"
echo "---------------------------------------"
  if is_supported_project "$PROJ"; then

    NAME=$(basename "$PROJ" .csproj)
    #KEY="${PREFIX}_${NAME}"
    KEY="${PREFIX}"

    echo "---------------------------------------"
    echo "Scanning project: $NAME"
    echo "Project path: $PROJ"
    echo "Sonar key: $KEY"
    echo "---------------------------------------"

    dotnet sonarscanner begin \
      /k:"$KEY" \
      /o:"$ORG" \
      /d:sonar.host.url="$HOST_URL" \
      /d:sonar.token="$SONAR_TOKEN"

    echo "Restoring project"
    dotnet restore "$PROJ"

    echo "Building project"
    dotnet build "$PROJ" --no-restore

    echo "Running tests (if available)"
    dotnet test "$PROJ" --no-build || true

    dotnet sonarscanner end \
      /d:sonar.token="$SONAR_TOKEN"

    SCANNED_PROJECTS+=("$PROJ")

  fi

done

########################################
# Summary
########################################

echo ""
echo "======================================"
echo " Sonar Scan Summary"
echo "======================================"

echo ""
echo "Scanned Projects:"
for P in "${SCANNED_PROJECTS[@]}"
do
  echo "  ✔ $P"
done

echo ""
echo "Skipped Projects:"
for P in "${SKIPPED_PROJECTS[@]}"
do
  echo "  ✖ $P"
done

echo ""
echo "Total scanned: ${#SCANNED_PROJECTS[@]}"
echo "Total skipped: ${#SKIPPED_PROJECTS[@]}"

echo "======================================"
echo "Code Quality Analysis Completed"
echo "======================================"