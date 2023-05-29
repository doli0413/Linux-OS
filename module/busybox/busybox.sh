#!/bin/bash

busybox echo "busybox" > index.html
busybox cat index.html

busybox httpd -f -p 8080 &