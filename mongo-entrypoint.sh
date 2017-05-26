#!/bin/bash

# Start mongod with config file loaded (in the background)
/usr/bin/mongod --fork --config /mongodb.conf

# process that runs in the foreground to keep the container alive
tail -f /dev/null
