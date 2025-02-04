#!/bin/bash

comprobar_instalacion_gh() {
    if command -v gh &> /dev/null; then
        return 1  # gh está instalado
    else
        return 0  # gh no está instalado
    fi
}

comprobar_instalacion_gh

if [ $? -eq 1 ]; then
    echo "El programa gh ya está instalado"
else
    echo "El programa gh no está instalado"
fi

exit $?  # Devuelve el código de salida de la función



