### ialocal  

<img style="float:left" alt="http://hackingyseguridad.com/" src="https://github.com/hackingyseguridad/ialocal/blob/main/banner2.png">

Modelos de IA en local, offline y aislados, sin conexión a Internet, scripts de instalación y arranque rápido para usar asistentes de IA (Ollama, Qwen, Claude Code, OpenCode) como apoyo en tareas de hacking ético y pentesting, sin enviar datos a la nube; Es una colección de scripts en lenguaje, bash shell linux, python3 para **Linux/Debian/Kali** que automatizan la instalación de las herramientas necesarias para tener un asistente de IA funcionando **100% en local**, con privacidad , sin depender de servicios en la nube, y usarlo como herramienta para pruebas de deteción de vulnerabilides, pruebas de concepto y explotación , en auditorías de seguridad y pruebas de penetración autorizadas, hacking.

Cuando se trabaja con datos de clientes, resultados de escaneos, IPs internas o hallazgos de una auditoría, enviar esa información a un proveedor de IA en la nube puede ser un problema de **confidencialidad** y privacidad: - Usando IA local: 

- Privacidad, ningún dato saldria de la máquina, PC donde se ejecuta la IA en local pues esta aislado, sin salida a intenret. 
- Puedes trabajar en redes locales LAN aisladas / air-gapped.
- No habria coste recurrente de API., consumo de Tokens, suelen ser modelos OpenSource.
- El rendimiento depende solo del hardware en local (funciona incluso **sin GPU**, usando modelos pequeños en CPU). Los requerimientos para ejectuar en un PC en Local, modelos de IA, son altos: se requiere GPU/CPU,  memoria RAM y velocidad de proceso.
- Menores habilidades, quiza algunos de estos modelos en local + herramientas, son menos pesados, menor tamaño o mas antiguos y tenga menos habilidades analiticas en la detección de vulnerabilidades, POC o Exploit, comparado con los ultimos  modelos enromes online, en centros de procesos de datos la nube.
- Integragacion: Herramientas intermedias, Agentes como: Claude Code, OpenCode, Codex, Hermess, tienen una intergracion alta en el sistema operativo sobre el que corren.
usan las interfaces de red, LAN o WAN, ejecutan comandos y programas, uso de scripts, uso de discos y memroria para leer y guardar ficheros.
Ollama por si solo, carece de esa integración, necesitaria un Script que haga de puente con el sistema .  Ollama en solitario carece de esa integración.** Para que un modelo servido por Ollama pueda "actuar" sobre el sistema (como en un flujo Kali + Ollama + agente + pentesting), hace falta un script puente o un agente que traduzca las respuestas del modelo en acciones del sistema
- Importancia del Agente; El modelo de IA, por sí solo, hace relativamente poco. El LLM solo genera texto/decisiones; es el agente (Claude Code, OpenCode, Codex CLI, **La clave está en el Agente o herramienta intermedia**  que lo conecta con el modelo del  entorno y le permite actuar:  Claude Code, Codex, OpenCode, Harness, ..  y/o combinaciones de OLLAMA + Agente + Modelo local offline. (Kali + Ollama + agente + pentesting).
- Modelos pequeños antiguos, carecen de compatibilidad (Tool calling / Function calling) con las Herramientas intermedias/Agentes (ClaudeCode, OpenCode, Codex,.), para combinarse con OLLAMA en local, 
darán muchos problemas.  **Modelos recomendados por compatibilidad avanzada:** `deepseek-coder-v2`, `hf.co/moophlo/Qwen3-Coder-30B-A3B-Instruct-GGUF` y `gpt-oss:20b` destacan por soportar *function calling* de forma más robusta, siendo mejores candidatos para combinarse con agentes en flujos de pentesting local (Kali + Ollama + agente).:

### Ollama + Agente + Modelo local (Pentesting)

| Agente (Herramienta)      | Modelo IA local Offline | Comando: Ollama + Agente + Modelo (Kali/Pentesting) |
|---------------------------|-----------------------------------------------|---------|
| **OLLAMA**                | `deepseek-coder-v2:16b` | `ollama run deepseek-coder-v2:16b` |
| **OLLAMA + OpenCode**     | `deepseek-coder-v2:16b` | `ollama launch opencode --model deepseek-coder-v2:16b` |
| **OLLAMA + Claude Code**  | `deepseek-coder-v2:16b` | `ollama launch claude --model deepseek-coder-v2:16b ` |
| **OLLAMA + Codex CLI**    | `gpt-oss:20b` | `codex --oss --local-provider ollama --model gpt-oss:20b` |
| **OLLAMA + Harness**      | `deepseek-coder-v2:16b` | `harness run -model deepseek-coder-v2:16b` |

---

### Arquitectura 


[![http://hackingyseguridad.com/](https://github.com/hackingyseguridad/ialocal/raw/main/ialocal.png)](https://github.com/hackingyseguridad/ialocal/blob/main/ialocal.png)

---

### Instalación

Clona el repositorio y da permisos de ejecución a los scripts:

```bash
git clone https://github.com/hackingyseguridad/ialocal.git
cd ialocal
chmod +x *.sh
```

### Instalación completa (`instalar.sh`)

Instala todo el stack: Ollama, ajustes de fecha/hora y actualización del sistema, Claude Code, Codex CLI, OpenCode.

```bash
sudo sh instalar.sh
```
### OLLAMA modelos offline, en local

El script `ollama.sh` documenta cómo lanzar un modelo local **sin GPU**, usando solo CPU, integrado con distintos front-ends de agente:

```bash
# Ejemplo: lanzar deepseek-r1:1.5b con Ollama
ollama run deepseek-r1:1.5b

# Otros modelos offline, en local
ollama run gemma3:1b
ollama run hf.co/josephmayo/Qwen2.5-0.5B-Unfettered
ollama run llama3.2:1b

```

También es posible integrarlo en combinacion con Claude Code como front-end, con OpenCode, Codex, con en mismo patrón de comando.

###  Modelos en local offline Ollama recomendados

| Modelo | Peso | RAM | Comando en Ollama |
|---|---|---|---|
| Qwen2.5-0.5B-Unfettered | 1 GB | 1 GB | `ollama run hf.co/josephmayo/Qwen2.5-0.5B-Unfettered` |
| Cygnis Alpha | 1.5 GB | 1.5 GB | `ollama run CygnisAI/Cygnis-Alpha-1.7B-v0.1` |
| DeepSeek-R1:1.5B | 1.1 GB | 2 GB+ | `ollama run deepseek-r1:1.5b` |
| Gemma 3 Mini | 1 GB | 4 GB | `ollama run gemma3:1b` |
| Llama 3.2 | 1.3 GB | 4 GB+ | `ollama run llama3.2:1b` |
| Granite3-dense / granite3.1-dense | 2-8 GB | 4-16 GB+ | `ollama run granite3.1-dense` |
| Qwen3:4b | ~2.6 GB | 6 GB+ | `ollama run qwen3:4b` |
| WhiteRabbitNeo 7B | 4.5 GB | 8 GB+ | `ollama run WhiteRabbitNeo/WhiteRabbitNeo-2.5-Qwen-2.5-Coder-7B` |
| Qwen3:8b | ~5.2 GB | 8 GB+ | `ollama run qwen3:8b` |
| Qwen2.5-coder:7b | ~4.7 GB | 8 GB+ | `ollama run qwen2.5-coder:7b` |
| Llama3-Groq-Tool-Use:8b | ~4.7 GB | 8 GB+ | `ollama run llama3-groq-tool-use:8b` |
| Hermes3 (8b) | ~4.7 GB | 8 GB+ | `ollama run hermes3` |
| Mistral-Nemo:12b | ~7 GB | 12 GB+ | `ollama run mistral-nemo` |
| Qwen2.5-coder:14b | ~9 GB | 16 GB+ | `ollama run qwen2.5-coder:14b` |
| Qwen3:14b | ~9 GB | 16 GB+ | `ollama run qwen3:14b` |
| DeepSeek-Coder-V2:16B | ~8.9 GB (Q4) | 16 GB+ | `ollama run deepseek-coder-v2:16b` |
| GPT-OSS 20B | ~13 GB (MXFP4) | 16 GB+ | `ollama run gpt-oss:20b` |
| Mistral-Small | ~13 GB | 16 GB+ | `ollama run mistral-small` |
| WhiteRabbitNeo 7B (lazarevtill) | 15 GB | 16 GB+ | `ollama run lazarevtill/WhiteRabbitNeo-2.5-Qwen-2.5-Coder-7B` |
| Command-R | ~20 GB | 24 GB+ | `ollama run command-r` |
| Qwen2.5-coder:32b | ~20 GB | 32 GB+ | `ollama run qwen2.5-coder:32b` |
| Qwen3:32b | ~20 GB | 32 GB+ | `ollama run qwen3:32b` |
| Mixtral 8x7B | ~26 GB | 32 GB+ | `ollama run mixtral` |
| Qwen3-Coder-30B-A3B-Instruct (GGUF) | ~18-19 GB (Q4_K_M) | 32 GB+ | `ollama run hf.co/moophlo/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q4_K_M` |
| Llama3-Groq-Tool-Use:70b | ~40 GB | 48 GB+ | `ollama run llama3-groq-tool-use:70b` |
| Hermes3/Hermes4 (70b) | ~40 GB | 48 GB+ | `ollama run hermes3:70b` |
| Athene-v2 | ~40 GB | 48 GB+ | `ollama run athene-v2` |
| Firefunction-v2 | ~40 GB | 48 GB+ | `ollama run firefunction-v2` |
| Llama3.3:70b | ~40 GB | 48 GB+ | `ollama run llama3.3` |
| Command-R-Plus | ~59 GB | 64 GB+ | `ollama run command-r-plus` |


### Flujo de trabajo típico

1. `sudo sh instalar.sh` (o `instalarollama.sh` si solo quieres Ollama).
2. Descargar el modelo elegido: `ollama pull deepseek-r1:1.5b` (u otro de la tabla anterior).
3. Lanzar el modelo integrado con tu CLI de agente preferida (`ollama launch opencode --model ...` o `ollama launch claude --model ...`).
4. Trabajar completamente offline: los prompts, resultados de escaneos y hallazgos no salen de tu máquina.
5. Documentar y reportar los hallazgos siguiendo las prácticas de divulgación responsable descritas en `DISCLAMER.md`.

### Aviso legal y ético

Este proyecto se distribuye junto con un [descargo de responsabilidad](./DISCLAMER.md) y un [código de conducta](./CODIGODECONDUCTA.md) que **debes leer antes de usarlo**. En resumen:

- Uso **exclusivo** en sistemas propios o con autorización escrita explícita (pentest autorizado, red team con alcance definido, laboratorio propio).
- El usuario es el único responsable del cumplimiento legal en su jurisdicción.
- El autor no asume ninguna responsabilidad por el uso indebido de estas herramientas.
- Si vas a introducir datos sensibles de un cliente en un asistente de IA, usa siempre un modelo **local** (como el que instala este repositorio) en lugar de un servicio en la nube, y revisa las políticas de confidencialidad de tu contrato.

**El uso no autorizado de estas herramientas contra sistemas de terceros es ilegal** y puede constituir un delito conforme al Código Penal español, al RGPD, a la Directiva NIS y a normativas equivalentes en otros países (ver detalle completo en [`LICENSE`](./LICENSE)).

---

### Referencias

| Recurso | Enlace |
|---|---|
| Anthropic knowledge-work-plugins | <https://github.com/anthropics/knowledge-work-plugins> |
| Claude Security (beta pública) | <https://claude.com/product/claude-security#public-beta> |
| DeepSeek API Key | <https://platform.deepseek.com/api_keys>  |
| Codex DeepSeek | <https://api-docs.deepseek.com/quick_start/agent_integrations/codex/> |
| DeepSeek Code Harness | <https://github.com/deepseek-ai/deepseek-harness> |
| DeepSeek-Coder (repositorio) | <https://github.com/deepseek-ai/DeepSeek-Coder/> |
| Gemini-Cli en Kali Linux | <https://www.kali.org/tools/gemini-cli/> |
| Integración Ollama + Claude Code | <https://docs.ollama.com/integrations/claude-code#recommended-models> |
| KIMI K3 | <https://www.kimi.com/es-419/help/kimi-code/cli-getting-started/> |
| Offensive-Claude | <https://github.com/hypnguyen1209/offensive-claude> |
| Ollama | <https://ollama.com/> |
| Codex Cli GPT de OpenIA | <https://github.com/openai/codex/> |
| OpenAI Codex CLI (documentación oficial) | <https://developers.openai.com/codex/cli> |
| OpenClaw — guía de inicio | <https://docs.openclaw.ai/start/getting-started> |
| OpenCode | <https://opencode.ai/> |
| Pentest-Copilot | <https://github.com/bugbasesecurity/pentest-copilot> |
| QWEN Code | <https://qwen.ai/qwencode> |
| Repositorio OpenAI Codex (Apache-2.0, Rust) | <https://github.com/openai/codex> |
| tGPT | <https://github.com/aandrew-me/tgpt> |
| Enlace adicional | <http://goo.gl/ID8XBX> |

# 

<p align="center">
  <img src="https://github.com/hackingyseguridad/ialocal/blob/main/autor.png" alt="@antonio_taboada">
</p>

#

<p align="center">
  <a href="http://www.hackingyseguridad.com/">https://www.hackingyseguridad.com/</a>
</p>









