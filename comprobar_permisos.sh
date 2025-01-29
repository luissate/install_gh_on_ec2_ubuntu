#!/bin/bash

comprobarprivilegios() {
    if [ "$EUID" -eq 0 ]; then
        return 1
    else
        return 0
    fi
}

comprobarprivilegios

if [ $? -eq 1 ]; then
    echo "continúa la ejecución"
else
    echo "el script no se puede seguir ejecutando porque el usuario que lo ejecuta no tiene privilegios de root"
    exit 1
fi
