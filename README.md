#!/bin/bash

# Verificar si el script tiene privilegios de administrador
if [[ $EUID -ne 0 ]]; then
   echo "Este script debe ejecutarse con privilegios de administrador." 
   exit 1
fi

# Actualizar el sistema
echo "Actualizando los paquetes del sistema..."
apt-get update -y

# Instalar paquetes necesarios para permitir que apt utilice repositorios a través de HTTPS
echo "Instalando paquetes necesarios..."
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Agregar el repositorio oficial de Docker
echo "Añadiendo el repositorio de Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Actualizar la lista de paquetes nuevamente
echo "Actualizando los paquetes del sistema..."
apt-get update -y

# Instalar Docker
echo "Instalando Docker..."
apt-get install -y docker-ce

# Verificar si Docker se ha instalado correctamente
echo "Verificando instalación de Docker..."
docker --version
if [[ $? -ne 0 ]]; then
    echo "Hubo un error en la instalación de Docker."
    exit 1
else
    echo "Docker se ha instalado correctamente."
fi

# Iniciar un contenedor de Nginx redirigiendo el puerto 80 al puerto 3000
echo "Iniciando contenedor Nginx con puerto 80 redirigido al puerto 3000..."
docker run -d --name prueba -p 3000:80 nginx

# Verificar si el contenedor se ha iniciado correctamente
echo "Verificando el estado del contenedor..."
docker ps -f name=prueba
if [[ $? -eq 0 ]]; then
    echo "Contenedor Nginx 'prueba' está corriendo correctamente."
else
    echo "Hubo un problema al iniciar el contenedor Nginx."
    exit 1
fi

echo "¡Todo listo!"
