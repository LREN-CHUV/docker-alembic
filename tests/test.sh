#!/usr/bin/env bash

set -e

get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"

     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     cd -P "$( dirname "$SOURCE" )"
     pwd
}

cd "$(get_script_dir)"

if [ $NO_SUDO ]; then
  DOCKER_COMPOSE="docker-compose"
elif groups $USER | grep &>/dev/null '\bdocker\b'; then
  DOCKER_COMPOSE="docker-compose"
else
  DOCKER_COMPOSE="sudo docker-compose"
fi

$DOCKER_COMPOSE up -d test_db
$DOCKER_COMPOSE run wait_dbs

echo
echo "Test database migration"
$DOCKER_COMPOSE run alembic
$DOCKER_COMPOSE run alembic_db_check

echo
echo "Test idempotence"
$DOCKER_COMPOSE run alembic
$DOCKER_COMPOSE run alembic_db_check

# Cleanup
echo
$DOCKER_COMPOSE stop
$DOCKER_COMPOSE rm -f > /dev/null 2> /dev/null
