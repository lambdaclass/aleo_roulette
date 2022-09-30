#!/bin/bash

# Start API
nix-shell --command "make run_api" &
  
# Start FRONT
nix-shell --command "make run_front" &
  
# Wait for any process to exit
wait -n
  
# Exit with status of process that exited first
exit $?
