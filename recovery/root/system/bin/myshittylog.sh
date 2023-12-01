#!/bin/sh

mkdir -p /cache/myshittylog
dmesg -w > /cache/myshittylog/dmesg.txt &
logcat -b all > /cache/myshittylog/logcat.txt
