#!/bin/bash

check_gh_installed() {
    if command -v gh &> /dev/null; then
        return 1  # gh está instalado
    else
        return 0  # gh no está instalado
    fi
}

check_gh_installed
exit $?  # Devuelve el código de salida de la función


