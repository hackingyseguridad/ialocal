#!/bin/sh
# (R) hackingyseguridad.com 2026
# Script Bash Shell 1.0.x para ejecutar interface OpenCode, con ollana, impulsado por otro modelo offline
# Tenemos que instalar Ollama
#  curl -fsSL https://ollama.com/install.sh | sh
# Tenemos que instalar primero OpenCode, con API Gratuita, sin saldo ni inscripcion
#  curl -fsSL https://claude.ai/install.sh | bash
echo
echo "... "
echo "ollama launch opencode --model hf.co/josephmayo/Qwen2.5-0.5B-Unfettered"
echo
ollama -v
echo " "
cat << 'EOF'
                                   ▄
  █▀▀█ █▀▀█ █▀▀█ █▀▀▄ █▀▀▀ █▀▀█ █▀▀█ █▀▀█
  █  █ █  █ █▀▀▀ █  █ █    █  █ █  █ █▀▀▀
  ▀▀▀▀ █▀▀▀ ▀▀▀▀ ▀▀▀▀ ▀▀▀▀ ▀▀▀▀ ▀▀▀▀ ▀▀▀▀

EOF
echo
~/.local/bin/./claude -V
claude doctor
echo
echo "Interface OPENCODE , impulsado por otro modelo en local offline: -- hackingyseguridad.com -- v1.0 "
echo "/"
export LANG=es_US.UTF-8
export LC_ALL=es_ES.UTF-8
sleep 3

# Open Code impulsado por hf.co/josephmayo/Qwen2.5-0.5B-Unfettered offline!!!
# ollama launch opencode --model hf.co/josephmayo/Qwen2.5-0.5B-Unfettered
ollama launch opencode --model qwen3:8b

