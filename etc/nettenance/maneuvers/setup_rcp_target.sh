#!/bin/bash
# setup_rcp_target.sh

# $1: remote dir
# $2: ip of the source machine
# $3: netcating port

# Default port
PORT=$3
PORT=${PORT:-8901} # Avoid PORT=${3:-8901}, since
                   # load_script doesn't support it.

echo "TARGET MACHINE"
echo "=============="
echo

echo "Creating dir $1."
mkdir -p $1;
cd $1;

echo "Connection started. Decompressing."
nc $2 $PORT | pigz -d | tar xvf -

