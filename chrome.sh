#!/bin/bash
# (r) hacking y seguridad .com 2026 Version Beta - Antonio Taboada
# Script en Bash Shell 1.0.x. para detectar si Google Chrome esta instalado
# en Kali Linux (basado en Debian): si lo esta, lo lanza; si no, lo instala
# y despues lo lanza.

set -e

echo "###############################################################"
echo "Comprobando si Google Chrome esta instalado ..."
echo "###############################################################"
echo

CHROME_BIN=""

# Buscamos el binario habitual de Chrome estable
if command -v google-chrome-stable >/dev/null 2>&1; then
    CHROME_BIN="google-chrome-stable"
elif command -v google-chrome >/dev/null 2>&1; then
    CHROME_BIN="google-chrome"
fi

if [ -n "$CHROME_BIN" ]; then
    echo "Google Chrome ya esta instalado ($CHROME_BIN)."
else
    echo "Google Chrome NO esta instalado. Procediendo a instalarlo ..."
    echo

    echo "Instalando dependencias necesarias (wget, ca-certificates, curl) ..."
    sudo apt update
    sudo apt install -y wget ca-certificates curl

    cd /tmp

    echo "Descargando el paquete .deb de Google Chrome ..."
    wget -4 -O google-chrome-stable_current_amd64.deb \
        https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

    echo "Instalando el paquete .deb ..."
    # apt install soluciona automaticamente las dependencias
    sudo apt install -y ./google-chrome-stable_current_amd64.deb

    # Por si quedara alguna dependencia rota
    sudo apt --fix-broken install -y

    if command -v google-chrome-stable >/dev/null 2>&1; then
        CHROME_BIN="google-chrome-stable"
    elif command -v google-chrome >/dev/null 2>&1; then
        CHROME_BIN="google-chrome"
    else
        echo "ERROR: la instalacion de Google Chrome ha fallado."
        exit 1
    fi

    echo "Google Chrome instalado correctamente."
fi

echo
echo "###############################################################"
echo "Ejecutando el navegador Google Chrome en Linux ..."
echo "###############################################################"
echo

"$CHROME_BIN" --no-sandbox --user-data-dir="$HOME/.config/google-chrome-script" &

exit 0
