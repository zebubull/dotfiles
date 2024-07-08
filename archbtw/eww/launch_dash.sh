#!/bin/bash

eww active-windows | grep -q dash
status=$?
if [[ $status == 1 ]]; then
    eww open dash
else
    eww close dash
fi
