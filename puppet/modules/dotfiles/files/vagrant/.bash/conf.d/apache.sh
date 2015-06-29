#!/usr/bin/env bash

if [ 0 -eq $UID ]; then
  alias ka='/etc/init.d/apache2 stop && /etc/init.d/apache2 start'

else
  alias ka='sudo /etc/init.d/apache2 stop && sudo /etc/init.d/apache2 start'
fi

