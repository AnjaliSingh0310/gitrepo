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

if [[ -z "$PREFIX" || -z "$HOST_URL" || -z "$SONAR_TOKEN" ]]; then
  echo "Required parameters:"
  echo "--project-key-prefix"
  echo "--host-url"
  echo "--token"
  exit 1
fi

########################################
# Install Scanners
########################################
echo "Installing tools..."

dotnet tool install --global dotnet-sonarscanner || true
export PATH="$PATH:$HOME/.dotnet/tools"

########################################
# Utility function
########################################
run_scan () {

  PROJECT_NAME=$1
  PROJECT_PATH=$2
  LANGUAGE=$3

  KEY="${PREFIX}_${PROJECT_NAME}"

  echo "-----------------------------------"
  echo "Scanning $PROJECT_NAME ($LANGUAGE)"
  echo "Path: $PROJECT_PATH"
  echo "Sonar key: $KEY"
  echo "-----------------------------------"

  sonar-scanner \
    -Dsonar.projectKey="$KEY" \
    -Dsonar.sources="$PROJECT_PATH" \
    -Dsonar.host.url="$HOST_URL" \
    -Dsonar.login="$SONAR_TOKEN"
}

########################################
# Detect .NET projects
########################################
echo "Searching .NET projects..."

find . -name "*.sln" | while read SOLUTION
do

  NAME=$(basename "$SOLUTION" .sln)

  echo "Running .NET analysis for $NAME"

  dotnet sonarscanner begin \
    /k:"${PREFIX}_${NAME}" \
    /o:"$ORG" \
    /d:sonar.host.url="$HOST_URL" \
    /d:sonar.token="$SONAR_TOKEN"

  dotnet restore "$SOLUTION"
  dotnet build "$SOLUTION"
  dotnet test "$SOLUTION" --collect:"XPlat Code Coverage" || true

  dotnet sonarscanner end /d:sonar.token="$SONAR_TOKEN"

done

########################################
# Detect Java (Maven)
########################################
echo "Searching Maven projects..."

find . -name "pom.xml" | while read POM
do
  DIR=$(dirname "$POM")
  NAME=$(basename "$DIR")

  echo "Running Maven analysis for $NAME"

  mvn -f "$POM" clean verify sonar:sonar \
    -Dsonar.projectKey="${PREFIX}_${NAME}" \
    -Dsonar.host.url="$HOST_URL" \
    -Dsonar.login="$SONAR_TOKEN"

done

########################################
# Detect Node projects
########################################
echo "Searching Node projects..."

find . -name "package.json" | while read PKG
do
  DIR=$(dirname "$PKG")
  NAME=$(basename "$DIR")

  echo "Running Node analysis for $NAME"

  pushd "$DIR"

  npm install || true

  sonar-scanner \
    -Dsonar.projectKey="${PREFIX}_${NAME}" \
    -Dsonar.sources="." \
    -Dsonar.host.url="$HOST_URL" \
    -Dsonar.login="$SONAR_TOKEN"

  popd

done

########################################
# Detect Python projects
########################################
echo "Searching Python projects..."

find . -name "*.py" | while read PY
do
  DIR=$(dirname "$PY")
  NAME=$(basename "$DIR")

  run_scan "$NAME" "$DIR" "python"

done

echo "======================================"
echo "Repository scan complete"
echo "======================================"