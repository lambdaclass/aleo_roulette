#!/bin/bash

# Run a circuit to force parameters dowloading and setup
nix-shell --command  "cd circuits/bets && aleo clean && aleo build  && aleo run psd_hash 3u32"

# Start API
nix-shell --command "make run_api" &
  
# Start FRONT
nix-shell --command "make run_front" &
  
# Wait for any process to exit
wait -n
  
# Exit with status of process that exited first
exit $?
