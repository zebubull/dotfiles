#!/bin/bash

eww active-windows | grep -q bar
status=$?
if [[ $status == 1 ]]; then
    eww open bar
else
    eww close bar
fi
