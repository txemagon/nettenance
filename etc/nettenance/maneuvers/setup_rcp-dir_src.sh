#/bin/bash
# Setup the source machine to open
# a netcat and start pushing data through
# it.


# $1: Path to the directory to copy
# $2: port for netcating.

# Default port
PORT=$2
PORT=${PORT:-8901}  # Avoid PORT=${2:-8901}, since
                    # load_script does not support it.

echo "SOURCE MACHINE"
echo "=============="
echo

pushd $1
cd ..
BASEDIR=$(pwd) # Base de directory.
            # The place we are going to commpress from.
echo "$BASEDIR entered."
PATH=$1
TARGETDIR="${PATH##$BASEDIR/}"

echo "COnnection started and compressing."
tar -c $TARGETDIR | pv --size $( du -sb $BASEDIR | cut -f1 ) | pigz -5 | nc -l $PORT
echo 'Back to: '
popd


# Aditional notes.
# Pushing and poping is usually not necessary since commands,
# like setup_rcp-dir_sr.sh are normally executed in a subshell.


