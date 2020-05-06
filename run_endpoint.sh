#!/bin/bash

# Set up the routing needed for the simulation.
/setup.sh

# The following variables are available for use:
# - ROLE contains the role of this execution context, client or server
# - SERVER_PARAMS contains user-supplied command line parameters
# - CLIENT_PARAMS contains user-supplied command line parameters

if [ "$ROLE" = "client" ]; then
    # Wait for the simulator to start up.
    /wait-for-it.sh sim:57832 -s -t 30

	# Create dummy foreground process to keep container running
	tail -f /dev/null

    # echo "Starting client with params ${CLIENT_PARAMS}"
	# python3 examples/http3_client.py \
	# 	--ca-certs tests/pycacert.pem \
	# 	$CLIENT_PARAMS \
	# 	https://193.167.100.100:4433/
	# echo "Exiting client"

elif [ "$ROLE" = "server" ]; then
    echo "Starting server with params ${SERVER_PARAMS}"
	python3 examples/http3_server.py \
		--certificate tests/ssl_cert.pem \
		--private-key tests/ssl_key.pem \
		$SERVER_PARAMS
	echo "Exiting server"
fi
