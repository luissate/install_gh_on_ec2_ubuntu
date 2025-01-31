#!/bin/bash

# Función que comprueba si el repositorio https://cli.github.com/packages está en el archivo /etc/apt/sources.list
comprobar_sourceslist() {
    # Comprobamos si la URL está en /etc/apt/sources.list
    if grep -q "https://cli.github.com/packages" /etc/apt/sources.list; then
        echo "El repositorio https://cli.github.com/packages stable main ya está en la lista de repositorios."
        return 1
    else
        # Si no está, comprobamos si el paquete gh está instalado
        if ! dpkg -l | grep -q "gh"; then
            echo "El paquete gh no está instalado."
            echo "El repositorio https://cli.github.com/packages stable main todavía no forma parte de la lista de repositorios."
            return 0
        fi
    fi
}

# Función que comprueba si el repositorio https://cli.github.com/packages está en los archivos de la carpeta /etc/apt/sources.list.d/
comprobar_carpeta_sourceslist_d() {
    # Comprobamos si la URL está en algún archivo de /etc/apt/sources.list.d/
    if grep -q "https://cli.github.com/packages" /etc/apt/sources.list.d/*; then
        echo "El repositorio https://cli.github.com/packages está en algún archivo de /etc/apt/sources.list.d/"
        return 1
    else
        echo "El repositorio https://cli.github.com/packages NO está en /etc/apt/sources.list.d/"
        return 0
    fi
}

# Llamamos a las dos funciones y mostramos sus resultados
comprobar_sourceslist
resultado_sourceslist=$?
comprobar_carpeta_sourceslist_d
resultado_sourceslist_d=$?

# Mostrar los resultados finales
echo "Resultado de comprobar_sourceslist: $resultado_sourceslist"
echo "Resultado de comprobar_carpeta_sourceslist_d: $resultado_sourceslist_d"

# Hacer commit en GitHub
git status
git add *
git commit -m "modificación nombre apellido"
git push
