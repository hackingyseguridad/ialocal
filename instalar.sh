#!/bin/sh
# (R) Antonio Taboada - hackingyseguridad.com 2026
#
# Script de instalacion de herramientas para IA / hacking con IA en local
# Compatible con /bin/sh (Bourne/POSIX shell) - sin bashismos, para sistemas
# antiguos o minimalistas (dash, ash, busybox sh, etc.)
#
# Cubre: Ollama, Node.js, Claude Code, Codex CLI, OpenCode, Harness (DeepSeek)
# ------------------------------------------------------------------------

echo " "
echo "Instalando herramientas para hacking con IA ..."
echo "(R) hackingyseguridad.com 2026"
echo " "

# ------------------------------------------------------------------------
# 0) COMPROBACIONES PREVIAS
# ------------------------------------------------------------------------

if [ "$(id -u)" -ne 0 ]; then
    echo "Aviso: este script instala paquetes de sistema (apt-get)."
    echo "Ejecutalo con sudo o como root si falla algun paso."
fi

echo "Sistema:"
uname -a
date
echo " "

# ------------------------------------------------------------------------
# 1) ACTUALIZACION DE SISTEMA, HORA Y ZONA HORARIA
# ------------------------------------------------------------------------

echo "== Ajustando zona horaria y hora del sistema =="
timedatectl set-timezone Europe/Madrid
timedatectl set-local-rtc 1
timedatectl status

apt-get install -y ntpdate
ntpdate hora.ngn.rima-tde.net
timedatectl status

echo " "
echo "== Actualizando el sistema =="
dpkg --configure -a
apt-get clean
apt-get update
apt-get full-upgrade --fix-missing -y
apt-get dist-upgrade -y
apt-get autoremove -y
apt-get autoclean -y
apt-get update
apt-get -f -y install

echo " "
echo "== Paquetes base =="
apt-get install -y zstd
chmod 777 * 2>/dev/null

# ------------------------------------------------------------------------
# 2) NODE.JS (requerido por Claude Code, Codex, OpenCode, Harness)
# ------------------------------------------------------------------------

echo " "
echo "== Instalando Node.js (LTS) =="

if command -v node >/dev/null 2>&1; then
    echo "Node.js ya esta instalado: $(node -v)"
else
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
    apt-get install -y nodejs
fi

# ------------------------------------------------------------------------
# 3) OLLAMA
# ------------------------------------------------------------------------

echo " "
echo "== Instalando Ollama =="

if command -v ollama >/dev/null 2>&1; then
    echo "Ollama ya esta instalado ...!"
else
    echo "Instalando Ollama ..."
    curl -fsSL https://ollama.com/install.sh | sh
fi

# Intentar arrancar el servicio si existe systemctl
if command -v systemctl >/dev/null 2>&1; then
    if ! systemctl is-active ollama >/dev/null 2>&1; then
        echo "Iniciando servicio Ollama..."
        sudo systemctl start ollama
    fi
fi

# ------------------------------------------------------------------------
# 4) CLAUDE CODE (Anthropic)
# ------------------------------------------------------------------------

echo " "
echo "== Instalando Claude Code =="

if command -v claude >/dev/null 2>&1; then
    echo "Claude Code ya esta instalado ...!"
else
    curl -fsSL https://claude.ai/install.sh | bash
fi

export PATH="$HOME/.local/bin:$PATH"
# Persistir el PATH para futuras sesiones (bash):
# echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
# Persistir el PATH para futuras sesiones (zsh):
# echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc

# ------------------------------------------------------------------------
# 5) CODEX CLI (OpenAI)
# ------------------------------------------------------------------------

echo " "
echo "== Instalando Codex CLI =="
echo "Requiere API Key de OpenAI: https://platform.openai.com/api-keys"

if command -v codex >/dev/null 2>&1; then
    echo "Codex CLI ya esta instalado ...!"
else
    curl -fsSL https://chatgpt.com/codex/install.sh | sh
fi
# Binario instalado en: /root/.local/bin/codex

# ------------------------------------------------------------------------
# 6) OPENCODE
# ------------------------------------------------------------------------

echo " "
echo "== Instalando OpenCode =="

if [ -x "$HOME/.opencode/bin/opencode" ]; then
    echo "OpenCode ya esta instalado ...!"
else
    curl -fsSL https://opencode.ai/install | bash
fi
# Ejecutar con: ~/.opencode/bin/opencode

# ------------------------------------------------------------------------
# 7) HARNESS (DeepSeek) - requiere Node.js
# ------------------------------------------------------------------------

echo " "
echo "== Instalando Harness de DeepSeek =="
echo "Requiere API Key de DeepSeek: https://platform.deepseek.com/sign_in"

curl -fsSL https://raw.githubusercontent.com/peiyuwang54/deepseek-harness-cli/master/apps/cli/install/install.sh | sh

echo "...."
echo "....."

df -h
