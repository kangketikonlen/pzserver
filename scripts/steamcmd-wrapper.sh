#!/bin/bash

set -e

if [ -z "$STEAMCMD_SKIP" ]; then
  if [ -z "$STEAMCMD_APP_ID" ]; then
    echo "ERROR: STEAMCMD_APP_ID is required"
    exit 1
  fi

  [ -z "$STEAMCMD_NO_VALIDATE" ]   && validate="validate"
  [ -n "$STEAMCMD_BETA" ]          && beta="-beta $STEAMCMD_BETA"
  [ -n "$STEAMCMD_BETA_PASSWORD" ] && betapassword="-betapassword $STEAMCMD_BETA_PASSWORD"

  echo "Running steamcmd"
  steamcmd +force_install_dir /data \
    +login $STEAMCMD_LOGIN \
    +app_update $STEAMCMD_APP_ID $beta $betapassword $validate \
    +quit
  echo "Running server"
  /data/start-server.sh -servername $SERVERNAME
else
  echo "Skipping steamcmd"
fi

exec "$@"