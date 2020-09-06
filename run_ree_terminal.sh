#!/bin/bash

echo "Waiting qemu to launch terminal on 50001 ..."
while ! nc -z localhost 50001; do sleep 0.1; done
telnet localhost 50001