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
    --solution) SOLUTION="$2"; shift ;;
    *) echo "Unknown parameter: $1"; exit 1 ;;
  esac
  shift
done

########################################
# Validate required parameters
########################################
if [[ -z "$HOST_URL" || -z "$SONAR_TOKEN" || -z "$PROJECT_KEY" ]]; then
  echo "Required parameters:"
  echo "--hostUrl"
  echo "--sonarToken"
  echo "--projectKey"
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
# login name 
########################################

LOGIN=$(curl -s -u "$SONAR_TOKEN:" "$HOST_URL/api/users/current" | jq -r '.login')
echo "Authenticated as: $LOGIN"

########################################
# Check if project exists
########################################
echo "Checking if project exists..."

if [[ "$IS_SONARCLOUD" == true ]]; then
  PROJECT_EXISTS=$(curl -s -u "$SONAR_TOKEN:" "$HOST_URL/api/projects/search?projects=$PROJECT_KEY&organization=$ORG" | jq '.components | length')
else
  PROJECT_EXISTS=$(curl -s -u "$SONAR_TOKEN:" "$HOST_URL/api/projects/search?projects=$PROJECT_KEY" | jq '.components | length')
fi


echo "Project exists: $PROJECT_EXISTS"

########################################
# Create project if missing
########################################
if [[ "$PROJECT_EXISTS" == "0" ]]; then

  echo "Project does not exist. Creating project..."

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

    echo "Assigning permissions..."

    curl -u "$SONAR_TOKEN:" \
    -X POST "$HOST_URL/api/permissions/add_user" \
    -d "login=$LOGIN" \
    -d "permission=scan" \
    -d "projectKey=$PROJECT_KEY"

  fi

else
  echo "Project already exists"
fi

########################################
# Install scanners
########################################
echo "Installing scanners..."

dotnet tool install --global dotnet-sonarscanner || true
export PATH="$PATH:$HOME/.dotnet/tools"

echo "Installing Sonar Scanner..."
npm install -g sonar-scanner
echo "INSTALLED........"

########################################
# Function: scan .NET solution
########################################
scan_dotnet_solution() {

  echo "Detected .NET solution"

  #if sonarcloud, we need to include organization in the begin step, else it can be skipped
  if [[ "$IS_SONARCLOUD" == true ]]; then
    SONAR_BEGIN_CMD="dotnet sonarscanner begin \
      /k:\"$PROJECT_KEY\" \
      /o:\"$ORG\" \
      /d:sonar.host.url=\"$HOST_URL\" \
      /d:sonar.token=\"$SONAR_TOKEN\" \
      /d:sonar.qualitygate.wait=true"
  else
    SONAR_BEGIN_CMD="dotnet sonarscanner begin \
      /k:\"$PROJECT_KEY\" \
      /d:sonar.host.url=\"$HOST_URL\" \
      /d:sonar.token=\"$SONAR_TOKEN\" \
      /d:sonar.qualitygate.wait=true"
  fi     

  echo "Running SonarScanner for .NET begin step..."
  echo "Command: $SONAR_BEGIN_CMD"
  eval $SONAR_BEGIN_CMD
  echo "Restoring solution"
    
  # if not solution provided, find one
  if [[ -z "$SOLUTION" ]]; then
    SOLUTION=$(find . -name "*.sln" | head -1) 
    echo "No solution provided. Detected solution: $SOLUTION"
  fi 
  dotnet restore "$SOLUTION"
  dotnet build "$SOLUTION"
  dotnet test "$SOLUTION" || true

  dotnet sonarscanner end \
    /d:sonar.token="$SONAR_TOKEN"

  echo "Finished SonarScanner for .NET analysis"
}

########################################
# Function: scan Maven
########################################
scan_maven() {

  echo "Detected Maven project"

  #if sonarcloud, we need to include organization in the maven command, else it can be skipped
  if [[ "$IS_SONARCLOUD" == true ]]; then
    MVN_CMD="mvn -B clean verify sonar:sonar \
      -Dsonar.projectKey=\"$PROJECT_KEY\" \
      -Dsonar.organization=\"$ORG\" \
      -Dsonar.host.url=\"$HOST_URL\" \
      -Dsonar.login=\"$SONAR_TOKEN\""
  else
    MVN_CMD="mvn -B clean verify sonar:sonar \
      -Dsonar.projectKey=\"$PROJECT_KEY\" \
      -Dsonar.host.url=\"$HOST_URL\" \
      -Dsonar.login=\"$SONAR_TOKEN\""
  fi

    echo "Running SonarScanner for Maven..."
    eval $MVN_CMD
    echo "Finished Maven analysis"
}

########################################
# Function: scan generic repo
########################################
scan_generic() {

  echo "Scanning entire repository"

  sonar-scanner \
    -Dsonar.projectKey="$PROJECT_KEY" \
    -Dsonar.sources=. \
    -Dsonar.host.url="$HOST_URL" \
    -Dsonar.login="$SONAR_TOKEN" \
    -Dsonar.qualitygate.wait=true

    echo "Finished generic analysis"
}

########################################
# Determine analysis mode
########################################
if [[ -n "$SOLUTION" ]]; then

  echo "Solution provided: $SOLUTION"

  if [[ "$SOLUTION" == *.sln ]]; then
    scan_dotnet_solution

  elif [[ "$SOLUTION" == *pom.xml ]]; then
    scan_maven

  else
    echo "Unknown solution type"
    exit 1
  fi

else

  echo "No solution provided. Detecting technologies..."

  echo "Searching for .NET solutions..."
  if find . -name "*.sln" | grep -q .; then
    SOLUTION=$(find . -name "*.sln" | head -1)
    scan_dotnet_solution

  fi

  echo "Searching for Maven projects..."
  if find . -name "pom.xml" | grep -q .; then
    scan_maven

  fi

  echo "No specific solutions found. Running generic scan..."  
  scan_generic

fi

echo "====================================="
echo "Sonar analysis completed"
echo "====================================="