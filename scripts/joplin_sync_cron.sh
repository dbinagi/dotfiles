#!/bin/bash

export NVM_DIR="/home/bini/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm use v21.7.2 > /home/bini/joplinsync.log 2>&1
node --version >> /home/bini/joplinsync.log 2>&1
whereis joplin >> /home/bini/joplinsync.log 2>&1

if ps -p $(lsof -ti :41184) -o pid,ppid,cmd | grep joplin >/dev/null
then
    echo "El servidor de Joplin está en ejecución." >> /home/bini/joplinsync.log 2>&1
else
    echo "El servidor de Joplin no está en ejecución." >> /home/bini/joplinsync.log 2>&1
    /home/bini/.nvm/versions/node/v21.7.2/bin/joplin server start >> /home/bini/joplinsync.log 2>&1
fi

/home/bini/.nvm/versions/node/v21.7.2/bin/joplin sync >> /home/bini/joplinsync.log 2>&1
