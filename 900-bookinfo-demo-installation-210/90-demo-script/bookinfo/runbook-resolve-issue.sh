#!/bin/bash

source ./config.sh

echo "runbook process started ..... $(date)"

events-clear/clear-events.sh
iks/iks-login.sh
iks/scale-up.sh

echo "runbook process completed ..... $(date)"