### ialocal  

Modelos de IA en local, offline y aislados, sin conexión a Internet, scripts de instalación y arranque rápido para usar asistentes de IA (Ollama, Qwen, Claude Code, OpenCode) como apoyo en tareas de hacking ético y pentesting, sin enviar datos a la nube; Es una colección de scripts en lenguaje, bash shell linux, python3 para **Linux/Debian/Kali** que automatizan la instalación de las herramientas necesarias para tener un asistente de IA funcionando **100% en local**, con privacidad , sin depender de servicios en la nube, y usarlo como herramienta para pruebas de deteción de vulnerabilides, pruebas de concepto y explotación , en auditorías de seguridad y pruebas de penetración autorizadas, hacking.

Cuando se trabaja con datos de clientes, resultados de escaneos, IPs internas o hallazgos de una auditoría, enviar esa información a un proveedor de IA en la nube puede ser un problema de **confidencialidad** y privacidad: - Usando IA local: 

- Privacidad, ningún dato saldria de la máquina, PC donde se ejecuta la IA en local pues esta aislado, sin salida a intenret. 
- Puedes trabajar en redes locales LAN aisladas / air-gapped.
- No habria coste recurrente de API., consumo de Tokens, suelen ser modelos OpenSource.
- El rendimiento depende solo del hardware en local (funciona incluso **sin GPU**, usando modelos pequeños en CPU). Los requerimientos para ejectuar en un PC en Local, modelos de IA, son altos: se requiere GPU/CPU,  memoria RAM y velocidad de proceso.
- Menores habilidades, quiza algunos de estos modelos en local + herramientas, son menos pesados, menor tamaño o mas antiguos y tenga menos habilidades analiticas en la detección de vulnerabilidades, POC o Exploit, comparado con los ultimos  modelos enromes online, en centros de procesos de datos la nube.
- Ingragacion: Herramientas intermedias, Agentes como: Claude Code, OpenCode, Codex, Hermess, tienen una intergracion alta en el sistema operativo sobre el que corren.
usan las interfaces de red, LAN o WAN, ejecutan comandos y programas, uso de scripts, uso de discos y memroria para leer y guardar ficheros.
Ollama por si solo, carece de esa integración, necesitaria un Script que haga de puente con el sistema .
- Importancia del Agente; El modelo de IA, por sí solo, hace relativamente poco. **La clave está en el Agente o herramienta intermedia**  que lo conecta con el modelo del  entorno y le permite actuar:  Claude Code, Codex, OpenCode, Harness, ..  y/o combinaciones de OLLAMA + Agente + Modelo local offline:

| Agente (Herramienta)      | Modelo IA local Offline OpenSource                                                                 | Notas |
|---------------------------|--------------------------------------------------------------------------------------------|-------|
| **OLLAMA**                | `gemma3:1b`, `deepseek-r1:1.5b`, `llama3.2:1b`, `hf.co/josephmayo/Qwen2.5-0.5B-Unfettered`, `qwen2.5-coder:1.5b`, `phi3.5:3.8b` | Runtime base para servir modelos locales vía API compatible (`localhost:11434`). |
| **OLLAMA + Claude Code**  | `qwen2.5-coder:7b/14b/32b`, `deepseek-coder-v2:16b`, `codellama:13b/34b`                    | Requiere un proxy/adaptador (p. ej. `claude-code-router` o similar) que traduzca la API de Anthropic a la API de OLLAMA. |
| **OLLAMA + OpenCode**     | `qwen2.5-coder`, `deepseek-r1`, `llama3.1:8b`                                               | OpenCode soporta backends OpenAI-compatible de forma nativa; apuntar `base_url` a OLLAMA. |
| **OLLAMA + Codex CLI**    | `qwen2.5-coder:32b`, `deepseek-coder-v2`                                                    | Codex CLI (OpenAI) admite endpoints compatibles vía configuración de `provider`/`base_url` personalizada. |
| **OLLAMA + Harness**      | *(`deepseek-coder-v2`)*                                                             |  "agent harness" propio o de terceros, especifica cuál para documentar la integración exacta. |

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

###  Modelos recomendados

| Modelo | Peso | RAM | Comando en Ollama |
|---|---|---|---|
| Qwen2.5-0.5B-Unfettered | 1 GB | 1 GB | `ollama run hf.co/josephmayo/Qwen2.5-0.5B-Unfettered` |
| Gemma 3 Mini | 1 GB | 4 GB | `ollama run gemma3:1b` |
| DeepSeek-R1:1.5B | 1.1 GB | 2 GB+ | `ollama run deepseek-r1:1.5b` |
| Llama 3.2 | 1.3 GB | 4 GB+ | `ollama run llama3.2:1b` |
| Cygnis Alpha | 1.5 GB | 1.5 GB | `ollama run CygnisAI/Cygnis-Alpha-1.7B-v0.1` |
| WhiteRabbitNeo 7B | 4.5 GB | 8 GB+ | `ollama run WhiteRabbitNeo/WhiteRabbitNeo-2.5-Qwen-2.5-Coder-7B` |
| WhiteRabbitNeo 7B (lazarevtill) | 15 GB | 16 GB+ | `ollama run lazarevtill/WhiteRabbitNeo-2.5-Qwen-2.5-Coder-7B` |

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
  <a href="https://www.hackingyseguridad.com/">https://www.hackingyseguridad.com/</a>
</p>









