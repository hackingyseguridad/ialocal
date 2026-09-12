#!/bin/sh
# IA en Local sin GPU offline !
# @antonio_taboada - hackingyseguridad.com - 2026

echo " "
echo "IA en Local sin GPU !"
echo "ejecuta MODELOS de Ollama en LOCAL offline, solos , combinados con Claude Codex, OpenCode, Codex "
echo " "
echo "Pentesting con IA local: sin mandar datos fuera. Ollama + modelos abiertos + Kali/OpenCode, viendo qué se puede hacer realmente offline y qué se pierde frente a modelos potentes en la nube. Para un entorno corporativo, el debate de privacidad puede dar muchísimo juego."
echo

# MODELOS DE OLLAMA en LOCAL combinados con herramienta OpenCode y sin GPU !! solo CPU
# ------------------------------------------------------------------------------------
# ollama launch opencode --model deepseek-r1:1.5b
# ollama launch opencode --model monotykamary/whiterabbitneo-v1.5a 
# ollama launch opencode --model captainkyd/whiterabbitneo7b
# ollama launch opencode --model lazarevtill/WhiteRabbitNeo-2.5-Qwen-2.5-Coder-7B

# MODELOS DE OLLAMA en LOCAL combinados con herramienta OpenCode y sin GPU !! solo CPU
# ------------------------------------------------------------------------------------
# ollama launch claude --model deepseek-r1:1.5b
# ollama launch claude --model monotykamary/whiterabbitneo-v1.5a 
# ollama launch claude --model captainkyd/whiterabbitneo7b
# ollama launch claude --model lazarevtill/WhiteRabbitNeo-2.5-Qwen-2.5-Coder-7B

# MODELOS DE OLLAMA DIRECTAEMENTE EN LOCAL, 
# -----------------------------------------------
ollama run deepseek-r1:1.5b



