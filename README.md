### ialocal 

Ejecutar modelos de inteligencia artificial, en un PC en local, offline, sin internet, maxima privacidad 

<img style="float:left" alt="http://hackingyseguridad.com/" src="https://github.com/hackingyseguridad/ialocal/blob/main/banner2.png">

Modelos de IA en local, offline y aislados, sin conexión a Internet, scripts de instalación y arranque rápido para usar asistentes de IA (Ollama, Qwen, Claude Code, OpenCode) como apoyo en tareas de hacking ético y pentesting, sin enviar datos a la nube; Es una colección de scripts en lenguaje, bash shell linux, python3 para **Linux/Debian/Kali** que automatizan la instalación de las herramientas necesarias para tener un asistente de IA funcionando **100% en local**, con privacidad , sin depender de servicios en la nube, y usarlo como herramienta para pruebas de deteción de vulnerabilides, pruebas de concepto y explotación , en auditorías de seguridad y pruebas de penetración autorizadas, hacking.

<img style="float:left" alt="http://hackingyseguridad.com/" src="https://github.com/hackingyseguridad/ialocal/blob/main/ialocal.png">

Cuando se trabaja con datos de clientes, resultados de escaneos, vulnerabilidades CVE, IPs internas o hallazgos de una auditoría, enviar esa información a un proveedor de IA en un centro de proceso de datos en la nube puede ser un problema de **confidencialidad** y privacidad: - **Usando IA local:** 

- PC, con sistema operativo Kali Linux (debian) con maximas prestaciones posibles de rendimineto en la CPU/GPU, Disco duro y memria RAM; 
- Privacidad; ningún dato saldria de la máquina, PC donde se ejecuta la IA en local pues esta aislado, sin salida a intenret. 
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

<img style="float:left" alt="http://hackingyseguridad.com/" src="https://github.com/hackingyseguridad/ialocal/blob/main/minipc.png">


### Ollama + Agente + Modelo local (Pentesting/Kali Linux)

| Agente (Herramienta)      | Modelo IA local Offline | Comando: Ollama + Agente + Modelo (Kali/Pentesting) |
|---------------------------|-----------------------------------------------|---------|
| **OLLAMA**                | `deepseek-coder-v2:16b` | `ollama run deepseek-coder-v2:16b` |
| **OLLAMA + OpenCode**     | `deepseek-coder-v2:16b` | `ollama launch opencode --model qwen3:8bd` |
| **OLLAMA + Claude Code**  | `deepseek-coder-v2:16b` | `ollama launch claude --model qwen3:8b` |
| **OLLAMA + Codex CLI**    | `gpt-oss:20b` | `codex --oss --local-provider ollama --model gpt-oss:20b` |
| **OLLAMA + Harness**      | `deepseek-coder-v2:16b` | `harness run -model deepseek-coder-v2:16b` |

---

### Arquitectura 


[![http://hackingyseguridad.com/](https://github.com/hackingyseguridad/ialocal/raw/main/arquitectura.png)](https://github.com/hackingyseguridad/ialocal/blob/main/arquitectura.png)

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

###  Modelos en local offline Ollama recomendados  ( * sin GPU )

| Modelo | Peso | RAM | Comando en Ollama |
|---|---|---|---|
| Qwen2.5-0.5B-Unfettered * | 1 GB | 1 GB | `ollama run hf.co/josephmayo/Qwen2.5-0.5B-Unfettered` |
| Cygnis Alpha | 1.5 GB | 1.5 GB | `ollama run CygnisAI/Cygnis-Alpha-1.7B-v0.1` |
| DeepSeek-R1:1.5B * | 1.1 GB | 2 GB | `ollama run deepseek-r1:1.5b` |
| Gemma 3 Mini | 1 GB | 4 GB | `ollama run gemma3:1b` |
| Llama 3.2 * | 1.3 GB | 4 GB | `ollama run llama3.2:1b` |
| Granite3-dense / granite3.1-dense | 8 GB | 16 GB | `ollama run granite3.1-dense` |
| Qwen3:4b * | 2.6 GB  | 6 GB | `ollama run qwen3:4b` |
| WhiteRabbitNeo 7B | 4.5 GB | 8 GB | `ollama run WhiteRabbitNeo/WhiteRabbitNeo-2.5-Qwen-2.5-Coder-7B` |
| Qwen3:8b * | 5.2 GB | 8 GB | `ollama run qwen3:8b` |
| Qwen2.5-coder:7b | 4.7 GB | 8 GB | `ollama run qwen2.5-coder:7b` |
| Llama3-Groq-Tool-Use:8b | 4.7 GB | 8 GB | `ollama run llama3-groq-tool-use:8b` |
| Hermes3 (8b) | 4.7 GB | 8 GB | `ollama run hermes3` |
| Mistral-Nemo:12b | 7 GB | 12 GB | `ollama run mistral-nemo` |
| Qwen2.5-coder:14b * | 9 GB | 16 GB | `ollama run qwen2.5-coder:14b` |
| Qwen3:14b | 9 GB | 16 GB | `ollama run qwen3:14b` |
| DeepSeek-Coder-V2:16B * | 8.9 GB | 16 GB | `ollama run deepseek-coder-v2:16b` |
| GPT-OSS 20B * | 13 GB | 16 GB | `ollama run gpt-oss:20b` |
| phi4-mini * | 2.5 GB | 3 GB |  `ollama run phi4-mini` |
| Mistral-Small | 13 GB | 16 GB | `ollama run mistral-small` |
| WhiteRabbitNeo 7B (lazarevtill) | 15 GB | 16 GB | `ollama run lazarevtill/WhiteRabbitNeo-2.5-Qwen-2.5-Coder-7B` |
| Command-R | 20 GB | 24 GB | `ollama run command-r` |
| Qwen2.5-coder:32b | 20 GB | 32 GB | `ollama run qwen2.5-coder:32b` |
| Qwen3:32b | 20 GB | 32 GB | `ollama run qwen3:32b` |
| Mixtral 8x7B * | 26 GB | 32 GB | `ollama run mixtral` |
| Qwen3-Coder-30B-A3B-Instruct | 19 GB | 32 GB | `ollama run hf.co/moophlo/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q4_K_M` |
| Llama3-Groq-Tool-Use:70b | 40 GB | 48 GB | `ollama run llama3-groq-tool-use:70b` |
| Hermes3/Hermes4 (70b) | 40 GB | 48 GB | `ollama run hermes3:70b` |
| Athene-v2 | 40 GB | 48 GB | `ollama run athene-v2` |
| Firefunction-v2 | 40 GB | 48 GB | `ollama run firefunction-v2` |
| Llama3.3:70b | 40 GB | 48 GB | `ollama run llama3.3` |
| Command-R-Plus | 59 GB | 64 GB | `ollama run command-r-plus` |


### Flujo de trabajo típico

1. `sudo sh instalar.sh` (o `instalarollama.sh` si solo quieres Ollama).
2. Descargar el modelo elegido: `ollama pull deepseek-r1:1.5b` (u otro de la tabla anterior).
3. Lanzar el modelo integrado con tu CLI de agente preferida (`ollama launch opencode --model ...` o `ollama launch claude --model ...`).
4. Trabajar completamente offline: los prompts, resultados de escaneos y hallazgos no salen de tu máquina.
5. Documentar y reportar los hallazgos siguiendo las prácticas de divulgación responsable descritas en `DISCLAMER.md`.


---

# IA aplicada a la Ciberseguridad Ofensiva — *Offensive IA* (edición OpenCode)

> **Inteligencia Artificial aplicada a la detección y explotación de vulnerabilidades en entornos de auditoría de seguridad autorizada, usando OpenCode como agente de codificación.**

📖 [INTRODUCCIÓN](https://github.com/hackingyseguridad/IA/blob/main/INTRODUCCION.md) · 💻 [USO IA POR CONSOLA TERMINAL(CLI)](https://github.com/hackingyseguridad/IA/blob/main/CONSOLA.md) · 📝 [PROMPTS](https://github.com/hackingyseguridad/IA/blob/main/PROMPTS.md) · 📝 [AGENTS](./AGENTS.md) · ⚖️ [AVISO LEGAL](https://github.com/hackingyseguridad/IA/blob/main/DISCLAIMER.md)

---

## IAlocal ( Pentesting con inteligencia artificial )

La Inteligencia Artificial actúa como un **asistente experto especializado** con alto nivel de conocimiento en programación y ciberseguridad. Sus capacidades en el contexto de una auditoría de seguridad incluyen:

- **Conocimiento de vulnerabilidades:** evalúa y describe CVEs (*Common Vulnerabilities and Exposures*), sugiere vectores de ataque y analiza código en busca de fallos de lógica que herramientas tradicionales ignoran.
- **Generación de scripts:** produce código de prueba en múltiples lenguajes (Bash, Python, C) para: pruebas de detección, pruebas de concepto (POC) y scripts de explotación de vulnerabilidades confirmadas.
- **Aceleración del proceso:** ayuda a ejecutar las pruebas de forma más rápida y eficiente, reduciendo el tiempo invertido en tareas repetitivas o de análisis masivo de datos.

> **-** La IA no sustituye todavía el criterio humano en una auditoría. El auditor sigue siendo quien rige el proceso y el único responsable de validar hallazgos, acciones y conclusiones.

---

## Proceso de Pentesting Integrado: Kali Linux + IA

| Fase | 1º | 2º | 3º | 4º | 5º | 6º |
|------|:--:|:--:|:--:|:--:|:--:|:--:|
| **Etapa** | Reconocimiento (RECON / OSINT) | Escaneo de vulnerabilidades (SCAN) | Clasificación y análisis IA (VULN) | Prueba de concepto (POC) | Explotación (EXPLOIT) | Informe final (REPORT) |
| **Herramienta** | IA + OSINT | nmap, Nessus, Nikto… | IA analiza `.xml/.csv/.txt` | Scripts IA | Scripts IA | Informe PDF con IA |

---

## Fases del Proceso de Hacking Ético

| Fase | Descripción | Acción / Scripts / Prompt |
|:-----|:------------|:--------------------------|
| **1. Reconocimiento (Recon)** | Recopilación de activos: IPs, FQDNs, rangos, URLs, puertos y URIs. La IA analiza y clasifica los datos proporcionados por el auditor, identificando superficies de ataque potenciales. | **Entrada:** listado de activos → la IA clasifica infraestructura y prioriza vectores de ataque. |
| **2. Escaneo y análisis** | Ejecución de herramientas de escaneo activo (nmap NSE, Nessus, Nikto, scripts personalizados). Los resultados se guardan en archivos estructurados (`.xml`, `.csv`, `.txt`) para su posterior análisis. | **Scripts disponibles:**<br>`redaudit.sh` — escaneo de puertos y servicios de red<br>`webaudit.sh` — auditoría de aplicaciones web y APIs<br>`fqdnaudit.sh` — análisis a partir de un FQDN |
| **3. Análisis IA de vulnerabilidades** | Analiza y clasifica las vulnerabilidades con IA. Según [Modo accesos IA](https://github.com/hackingyseguridad/IA/blob/main/INTRODUCCION.md#privacidad-de-los-datos-del-usuario-ia-modos): Web o modo comandos [por consola / terminal (CLI, OpenCode)](https://github.com/hackingyseguridad/IA/blob/main/CONSOLA.md): anexar fichero (`resultado.xml`) al agente con los datos obtenidos para que procese la información, con la instrucción [Prompt](https://github.com/hackingyseguridad/IA/blob/main/PROMPTS.md). | **Prompt sugerido:** *"Ordena en una tabla resumen ejecutivo los puertos/servicios con vulnerabilidades CVE críticas que tengan exploit conocido y sean explotables."* |
| **4. Prueba de Concepto (POC)** | Generación de scripts sencillos para verificar la existencia real de cada vulnerabilidad y descartar falsos positivos, sin causar daño en el sistema objetivo. | **Prompt sugerido:** *"Ordenados de más fácil a menos, genera la prueba de concepto (POC) en código simple: Bash Shell, Python o C."* |
| **5. Explotación (Exploit)** | Desarrollo o adaptación de exploits para las vulnerabilidades confirmadas en la fase anterior, priorizadas por facilidad de explotación. | **Prompt sugerido:** *"Código de los exploits disponibles, ordenados de mayor a menor facilidad de explotación."* |
| **6. Post-explotación e Informe** | Documentación de hallazgos, eliminación de huellas, redacción de recomendaciones de mitigación y generación del informe técnico y ejecutivo en formato PDF. | **Prompt sugerido:** *"Redacta un informe técnico y resumen ejecutivo con recomendaciones de parcheo basadas en las notas de hallazgos proporcionadas."* |

---

## Configuración específica de OpenCode

Este repositorio incluye un [`AGENTS.md`](./AGENTS.md) — el fichero de instrucciones que OpenCode carga automáticamente al arrancar en este directorio (equivalente al `CLAUDE.md` de Claude Code; OpenCode también lee `CLAUDE.md` por compatibilidad si existe, pero `AGENTS.md` es la convención nativa y portable entre agentes).

Los permisos de ejecución (qué comandos y ediciones se aplican sin preguntar) se definen en `opencode.json`, no en un fichero de configuración global de usuario. Ver la sección "Modo de permisos" de `AGENTS.md` para el detalle de las reglas.

## Modelos de IA compatibles

La metodología es agnóstica al modelo y al agente de codificación. Puede utilizarse con:

- **Agentes de codificación:** OpenCode, Claude Code, y otros compatibles con `AGENTS.md`
- **Modelos en la nube:** Claude (Anthropic), Gemini (Google), GPT-4 (OpenAI), Grok (xAI)
- **Modelos locales (privacidad total):** Llama, Mistral, DeepSeek, Qwen — ejecutados en local vía Ollama u otras interfaces

---

### Aviso legal y ético

Este proyecto se distribuye junto con un [descargo de responsabilidad](./DISCLAMER.md) y un [código de conducta](./CODIGODECONDUCTA.md) que **debes leer antes de usarlo**. En resumen:

- Uso **exclusivo** en sistemas propios o con autorización escrita explícita (pentest autorizado, red team con alcance definido, laboratorio propio).
- El usuario es el único responsable del cumplimiento legal en su jurisdicción.
- El autor no asume ninguna responsabilidad por el uso indebido de estas herramientas.
- Si vas a introducir datos sensibles de un cliente en un asistente de IA, usa siempre un modelo **local** (como el que instala este repositorio) en lugar de un servicio en la nube, y revisa las políticas de confidencialidad de tu contrato.

**El uso no autorizado de estas herramientas contra sistemas de terceros es ilegal** y puede constituir un delito conforme al Código Penal español, al RGPD, a la Directiva NIS y a normativas equivalentes en otros países (ver detalle completo en [`LICENSE`](./LICENSE)).

---

DeepSeel 1.5b

<img style="float:left" alt="http://hackingyseguridad.com/" src="https://github.com/hackingyseguridad/ialocal/blob/main/opencode.png">

Qwen 2.5

<img style="float:left" alt="http://hackingyseguridad.com/" src="https://github.com/hackingyseguridad/ialocal/blob/main/qwen2.png">

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
| OpenCode | <https://opencode.ai/> |
| QWEN Code | <https://qwen.ai/qwencode> |
| Repositorio OpenAI Codex (Apache-2.0, Rust) | <https://github.com/openai/codex> |
| Kali Linux | <https://kali.org/get-kali/> |
| Enlace adicional | <http://goo.gl/ID8XBX> |

# 

<p align="center">
  <img src="https://github.com/hackingyseguridad/ialocal/blob/main/autor.png" alt="@antonio_taboada">
</p>

#

<p align="center">
  <a href="http://www.hackingyseguridad.com/">https://www.hackingyseguridad.com/</a>
</p>









