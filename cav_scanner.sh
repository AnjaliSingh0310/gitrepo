#!/bin/bash
set -e

########################################
# Parse parameters
########################################
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --hostUrl) HOST_URL="$2"; shift ;;
    --sonarToken) SONAR_TOKEN="$2"; shift ;;
    --projectKey) PROJECT_KEY="$2"; shift ;;
    --organization) ORG="$2"; shift ;;
    *) echo "Unknown parameter: $1"; exit 1 ;;
  esac
  shift
done

########################################
# Validate parameters
########################################
if [[ -z "$HOST_URL" || -z "$SONAR_TOKEN" || -z "$PROJECT_KEY" ]]; then
  echo "Required parameters: --hostUrl --sonarToken --projectKey"
  exit 1
fi

########################################
# Detect SonarCloud
########################################
IS_SONARCLOUD=false

if [[ "$HOST_URL" == *"sonarcloud.io"* ]]; then
  IS_SONARCLOUD=true
  echo "Detected SonarCloud"

  if [[ -z "$ORG" ]]; then
    echo "ERROR: SonarCloud requires --organization"
    exit 1
  fi
fi

########################################
# Get login
########################################
LOGIN=$(curl -s -u "$SONAR_TOKEN:" "$HOST_URL/api/users/current" | jq -r '.login')
echo "Authenticated as: $LOGIN"

########################################
# Create project if missing
########################################
create_project_if_missing() {

  if [[ "$IS_SONARCLOUD" == true ]]; then
    PROJECT_EXISTS=$(curl -s -u "$SONAR_TOKEN:" \
      "$HOST_URL/api/projects/search?projects=$PROJECT_KEY&organization=$ORG" \
      | jq '.components | length')
  else
    PROJECT_EXISTS=$(curl -s -u "$SONAR_TOKEN:" \
      "$HOST_URL/api/projects/search?projects=$PROJECT_KEY" \
      | jq '.components | length')
  fi

  echo "Project exists: $PROJECT_EXISTS"

  if [[ "$PROJECT_EXISTS" == "0" ]]; then

    echo "Creating project $PROJECT_KEY"

    if [[ "$IS_SONARCLOUD" == true ]]; then

      curl -u "$SONAR_TOKEN:" \
      -X POST "$HOST_URL/api/projects/create" \
      -d "organization=$ORG" \
      -d "project=$PROJECT_KEY" \
      -d "name=$PROJECT_KEY"

    else

      curl -u "$SONAR_TOKEN:" \
      -X POST "$HOST_URL/api/projects/create" \
      -d "project=$PROJECT_KEY" \
      -d "name=$PROJECT_KEY"

      curl -u "$SONAR_TOKEN:" \
      -X POST "$HOST_URL/api/permissions/add_user" \
      -d "login=$LOGIN" \
      -d "permission=scan" \
      -d "projectKey=$PROJECT_KEY"

    fi
  else
    echo "Project already exists"
  fi
}

########################################
# Install scanners
########################################
echo "Installing scanners..."

dotnet tool install --global dotnet-sonarscanner || true
export PATH="$PATH:$HOME/.dotnet/tools"

npm install -g sonar-scanner || true

########################################
# Detect technologies
########################################

DOTNET_SOLUTIONS=$(find . -name "*.sln" || true)
MAVEN_PROJECTS=$(find . -name "pom.xml" || true)
NODE_PROJECTS=$(find . -name "package.json" || true)
PY_PROJECTS=$(find . -name "requirements.txt" || true)
GO_PROJECTS=$(find . -name "go.mod" || true)

echo "Detected .NET solutions: $DOTNET_SOLUTIONS"
echo "Detected Maven projects: $MAVEN_PROJECTS"
echo "Detected NodeJS projects: $NODE_PROJECTS"
echo "Detected Python projects: $PY_PROJECTS"
echo "Detected Go projects: $GO_PROJECTS"

########################################
# Build stage
########################################

echo "====================================="
echo "Building monorepo projects"
echo "====================================="

build_dotnet() {
  for SLN in $DOTNET_SOLUTIONS; do
    DIR=$(dirname "$SLN")
    echo "Building .NET: $SLN"
    (
      cd "$DIR"
      dotnet restore "$SLN"
      dotnet build "$SLN"
      dotnet test "$SLN" || true
    ) &
  done
}

build_maven() {
  for POM in $MAVEN_PROJECTS; do
    DIR=$(dirname "$POM")
    echo "Building Maven: $POM"
    (
      cd "$DIR"
      mvn -B clean verify
    ) &
  done
}

build_node() {
  for PKG in $NODE_PROJECTS; do
    DIR=$(dirname "$PKG")
    echo "Building NodeJS: $PKG"
    (
      cd "$DIR"
      npm install
      npm test || true
    ) &
  done
}

build_python() {
  for REQ in $PY_PROJECTS; do
    DIR=$(dirname "$REQ")
    echo "Building Python: $REQ"
    (
      cd "$DIR"
      pip install -r requirements.txt || true
      pytest || true
    ) &
  done
}

build_go() {
  for MOD in $GO_PROJECTS; do
    DIR=$(dirname "$MOD")
    echo "Building Go: $MOD"
    (
      cd "$DIR"
      go mod tidy
      go test ./... || true
    ) &
  done
}

build_dotnet
build_maven
build_node
build_python
build_go

wait

########################################
# Create project
########################################
create_project_if_missing


#########################################

CFAMILY_OPTIONS=""

COMPILE_DB=$(find . -name "compile_commands.json" | head -1)

if [[ -n "$COMPILE_DB" ]]; then
  echo "C/C++ compilation database detected: $COMPILE_DB"
  CFAMILY_OPTION="-Dsonar.cfamily.compile-commands=$COMPILE_DB"
else
  echo "No compilation database found. Disabling C/C++ analysis."

  CFAMILY_OPTION="-Dsonar.c.file.suffixes=- -Dsonar.cpp.file.suffixes=- -Dsonar.objc.file.suffixes=-"
fi
########################################

echo "CFAMILY_OPTION: $CFAMILY_OPTION"

########################################
# Run Sonar scan
########################################

echo "====================================="
echo "Running Sonar analysis"
echo "====================================="

echo "All details:"
echo "HOST_URL: $HOST_URL"
echo "PROJECT_KEY: $PROJECT_KEY"
echo "ORG: $ORG"
echo "IS_SONARCLOUD: $IS_SONARCLOUD"  
echo "CFAMILY_OPTION: $CFAMILY_OPTION"

SCANNER_OPTS=(
  -Dsonar.projectKey=$PROJECT_KEY
  -Dsonar.sources=.
  -Dsonar.host.url=$HOST_URL
  -Dsonar.token=$SONAR_TOKEN
  -Dsonar.java.binaries=**/target/classes
)

if [ "$IS_SONARCLOUD" = "true" ]; then
  SCANNER_OPTS+=(-Dsonar.organization=$ORG)
fi

if [ -n "$CFAMILY_OPTION" ]; then
  SCANNER_OPTS+=($CFAMILY_OPTION)
fi

echo "Running scanner..."
echo "sonar-scanner ${SCANNER_OPTS[*]}"


sonar-scanner "${SCANNER_OPTS[@]}"

echo "====================================="
echo "Sonar analysis completed"
echo "====================================="