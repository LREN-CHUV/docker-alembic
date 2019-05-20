#!/usr/bin/env bash

#
# Execute the integration test suite in a Continuous Integration environment
#
# Option:
#   --all: execute the full suite of tests, including slow tests such as Chaos testing
#

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

# This script is used for publish and continuous integration.

get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"

     while [[ -h "$SOURCE" ]]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     cd -P "$( dirname "$SOURCE" )"
     pwd
}

cd "$(get_script_dir)"

if [[ $NO_SUDO || -n "$CIRCLECI" ]]; then
  DOCKER="docker"
  DOCKER_COMPOSE="docker-compose -f docker-compose-ci.yml"
elif groups "$USER" | grep &>/dev/null '\bdocker\b'; then
  DOCKER="docker"
  DOCKER_COMPOSE="docker-compose -f docker-compose-ci.yml"
else
  DOCKER="sudo docker"
  DOCKER_COMPOSE="sudo docker-compose -f docker-compose-ci.yml"
fi

$DOCKER_COMPOSE build
$DOCKER_COMPOSE up -d test_db
$DOCKER_COMPOSE run wait_dbs

echo
echo "Test database migration"
$DOCKER_COMPOSE run alembic
$DOCKER_COMPOSE run db_check

echo
echo "Test idempotence"
$DOCKER_COMPOSE run alembic
$DOCKER_COMPOSE run --name db_check db_check

exit_code="$($DOCKER inspect db_check --format='{{.State.ExitCode}}')"

if [[ "$exit_code" != "0" ]]; then
  echo "Integration tests failed!"
  exit 1
fi
echo "[OK] All integration tests passed."
