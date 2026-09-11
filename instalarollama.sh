#!/bin/sh
# (R) Antonio Taboada - hackingyseguridad.com 2026 
# Script para instalar ollama y poder ejecutar en local IA
echo "Instalando herramienta OLLAMA  ... "  
echo "(R) hackingyseguridad.com 2026 "
chmod 777 *
apt-get install zstd
echo
# Comprobar si ollama ya esta instalado 
if command -v ollama >/dev/null 2>&1; then
    echo "Ollama ya está instalado ...!"
else
    echo "Instalando Ollama ... "
    curl -fsSL https://ollama.com/install.sh | sh
fi

# Intentar arrancar el servicio si existe systemctl
if command -v systemctl >/dev/null 2>&1; then
    if ! systemctl is-active ollama >/dev/null 2>&1; then
        echo "Iniciando servicio Ollama..."
        sudo systemctl start ollama
    fi
fi
