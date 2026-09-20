#!/bin/sh
# (R) hackingyseguridad.com 2026
# Script Bash Shell 1.0.x para ejecutar interface Claude Code, con ollana, impulsado por otro modelo oFFLINE
# Tenemos que instalar Ollama
#  curl -fsSL https://ollama.com/install.sh | sh
# Tenemos que instalar primero Claude , con API Gratuita, sin saldo ni inscripcion
#  curl -fsSL https://claude.ai/install.sh | bash
echo
echo "... "
echo
ollama -v
echo " "
cat << 'EOF'
 ██████  ██       █████  ██    ██ ██████  ███████
██       ██      ██   ██ ██    ██ ██   ██ ██
██       ██      ███████ ██    ██ ██   ██ █████
██       ██      ██   ██ ██    ██ ██   ██ ██
 ██████  ███████ ██   ██  ██████  ██████  ███████

 ██████  ██████  ██████  ███████
██       ██   ██ ██   ██ ██
██       ██   ██ ██   ██ █████
██       ██   ██ ██   ██ ██
 ██████  ██████  ██████  ███████
EOF
echo
~/.local/bin/./claude -V
claude doctor
echo
echo "Interface CLAUDE CODE ,  impulsado por otro modelo online:cloud: -- hackingyseguridad.com -- v1.0 "
echo "/"
export LANG=es_US.UTF-8
export LC_ALL=es_ES.UTF-8
sleep 3

# ollama launch claude --model  gpt-oss:20b

ollama launch claude --model gemma4:31b

# ollama launch claude --model minimax-m3

# ollama launch claude --model qwen3-coder
