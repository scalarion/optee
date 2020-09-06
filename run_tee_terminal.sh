#!/bin/bash

echo "Waiting qemu to launch terminal on 50002 ..."
while ! nc -z localhost 50002; do sleep 0.1; done
telnet localhost 50002