
<h1 align="center">ialocal</h1>

<p align="center">
  <b>Modelos de IA en local, offline y aislados, sin conexión a Internet</b><br>
  Scripts de instalación y arranque rápido para usar asistentes de IA (Ollama, Qwen, Claude Code, OpenCode) como apoyo en tareas de hacking ético y pentesting, sin enviar datos a la nube.
</p>

[![http://hackingyseguridad.com/](https://github.com/hackingyseguridad/ialocal/raw/main/ialocal.png)](https://github.com/hackingyseguridad/ialocal/blob/main/ialocal.png)

<p align="center">
  <a href="http://www.hackingyseguridad.com/">hackingyseguridad.com</a> ·
  <a href="./LICENSE">Licencia MIT + cláusulas de seguridad</a> ·
  <a href="./DISCLAMER.md">Descargo de responsabilidad</a> ·
  <a href="./CODIGODECONDUCTA.md">Código de conducta</a>
</p>

---

###  Índice

- [¿Qué es ialocal?](#-qué-es-ialocal)
- [¿Por qué IA local?](#-por-qué-ia-local)
- [Contenido del repositorio](#-contenido-del-repositorio)
- [Requisitos](#-requisitos)
- [Instalación](#-instalación)
  - [Instalación completa](#instalación-completa-instalarsh)
  - [Solo Ollama](#solo-ollama-instalarollamash)
  - [Solo Qwen Code](#solo-qwen-code-instalarqwensh)
- [Uso: ejecutar modelos en local](#-uso-ejecutar-modelos-en-local)
- [Modelos recomendados](#-modelos-recomendados)
- [Flujo de trabajo típico](#-flujo-de-trabajo-típico)
- [Aviso legal y ético](#-aviso-legal-y-ético)
- [Licencia](#-licencia)
- [Autor](#-autor)

---

###  repositorio ialocal

**ialocal** es una colección de scripts en lenguaje, bash shell linux, python3 para **Linux/Debian/Kali** que automatizan la instalación de las herramientas necesarias para tener un asistente de IA funcionando **100% en local**, con privacidad , sin depender de servicios en la nube, y usarlo como herramienta para pruebas de deteción de vulnerabilides, pruebas de concepto y explotación , en auditorías de seguridad y pruebas de penetración autorizadas, hacking.

En una sola pasada, los scripts dejan preparado el sistema con:

- **[Ollama](https://ollama.com/)** — motor para ejecutar LLMs de pesos abiertos en local (CPU o GPU).
- **[Qwen Code](https://github.com/QwenLM)** — CLI de Qwen para tareas de programación asistida por IA.
- **Claude Code** — CLI oficial de Anthropic (instalación vía script oficial).
- **Codex CLI** (OpenAI) y **OpenCode** — CLIs alternativas de agentes de código.

###  IA en local, aislada

Cuando se trabaja con datos de clientes, resultados de escaneos, IPs internas o hallazgos de una auditoría, enviar esa información a un proveedor de IA en la nube puede ser un problema de **confidencialidad** y de cumplimiento contractual. Ejecutando el modelo en local con Ollama:

- Ningún dato sale de la máquina, PC donde corre la IA en local, pues esta aislado. 
- Puedes trabajar en redes aisladas / air-gapped.
- No hay coste recurrente de API., consumo de Tokens, suelen ser modelos OpenSource
- El rendimiento depende solo de tu hardware (funciona incluso **sin GPU**, usando modelos pequeños en CPU). Los requerimientos para ejectuar en un PC en Local, modelos de IA, son altos: se requiere GPU/CPU,  memoria RAM y velocidad de proceso.
- Menores habilidades, quiza algunos de estos modelos en local + herramientas, son menos pesados, menor tamaño o mas antiguos y tenga menos habilidades analiticas en la detección de vulnerabilidades, POC o Exploit, comparado con los ultimos  modelos enromes online, en centros de procesos de datos la nube


### Contenido del repositorio

| Archivo | Descripción |
|---|---|
| `instalar.sh` | Script principal. Instala Ollama, actualiza el sistema, ajusta la zona horaria, instala Claude Code, Codex CLI y OpenCode, y descarga diccionarios de `hackingyseguridad/diccionarios`. |
| `instalarollama.sh` | Instalación mínima: solo Ollama (y arranque del servicio si existe `systemctl`). |
| `instalarqwen.sh` | Instala **Qwen Code** de forma independiente. |
| `ollama.sh` | Script de referencia/documentación con ejemplos de comandos para lanzar modelos locales (p. ej. `deepseek-r1:1.5b`) sin GPU, integrados con OpenCode o Claude. |
| `DISCLAMER.md` | Descargo de responsabilidad sobre uso legal y ético de las herramientas. |
| `CODIGODECONDUCTA.md` | Código de conducta para colaboradores y usuarios. |
| `LICENSE` | Licencia MIT (ES/EN) ampliada con cláusulas de seguridad y referencias legales (España, UE, CFAA, Computer Misuse Act, etc.). |
| `ialocal.png`, `banner0.png`, `banner2.png` | Recursos gráficos del proyecto. |

###  Requisitos

- Distribución basada en **Debian/Ubuntu/Kali Linux** (los scripts usan `apt-get`/`apt`).
- Acceso a `sudo` / usuario `root`.
- Conexión a Internet **solo durante la instalación** (para descargar Ollama, los modelos y las CLIs). Una vez instalado, el uso del modelo es offline.
- Espacio en disco suficiente para los modelos (varían entre ~1 GB y varios GB según el modelo elegido).
- Opcional: GPU compatible para acelerar la inferencia (los scripts también funcionan solo con CPU).

### Instalación

Clona el repositorio y da permisos de ejecución a los scripts:

```bash
git clone https://github.com/hackingyseguridad/ialocal.git
cd ialocal
chmod +x *.sh
```

### Instalación completa (`instalar.sh`)

Instala todo el stack: Ollama, ajustes de fecha/hora y actualización del sistema, Claude Code, Codex CLI, OpenCode, y descarga los diccionarios de `ficheros.txt` / `ficheros2.txt` usados en otras herramientas de hackingyseguridad.

```bash
sudo sh instalar.sh
```

Al finalizar, el script indica los siguientes pasos manuales:

1. Ejecuta `~/.local/bin/claude` para lanzar Claude Code.
2. Elige la opción **2. Anthropic Console account · API usage billing**.
3. Abre el enlace de autorización OAuth que muestra la terminal, autoriza el acceso y pega el código en la consola.
4. Repite un proceso equivalente de autenticación para Ollama si tu flujo lo requiere.

>  El script modifica la zona horaria del sistema a `Europe/Madrid` y sincroniza la hora vía NTP (`timedatectl`, `ntpdate`). Revisa esas líneas si tu servidor necesita otra zona horaria.

### Solo Ollama (`instalarollama.sh`)

Si únicamente quieres el motor de modelos locales, sin el resto del stack:

```bash
sudo sh instalarollama.sh
```

Comprueba si Ollama ya está instalado y, si no lo está, lo instala con el script oficial (`ollama.com/install.sh`) e intenta arrancar el servicio con `systemctl`.

### Solo Qwen Code (`instalarqwen.sh`)

Instala la CLI de Qwen Code de forma independiente:

```bash
sh instalarqwen.sh
```

### Uso: ejecutar modelos en local

El script `ollama.sh` documenta cómo lanzar un modelo local **sin GPU**, usando solo CPU, integrado con distintos front-ends de agente:

```bash
# Ejemplo: lanzar deepseek-r1:1.5b con OpenCode
ollama launch opencode --model deepseek-r1:1.5b

# Otras variantes orientadas a seguridad ofensiva
ollama launch opencode --model monotykamary/whiterabbitneo-v1.5a
ollama launch opencode --model captainkyd/whiterabbitneo7b
ollama launch opencode --model lazarevtill/WhiteRabbitNeo-2.5-Qwen-2.5-Coder-7B
```

También es posible integrarlo con Claude Code como front-end en lugar de OpenCode, sustituyendo `opencode` por `claude` en el mismo patrón de comando.

###  Modelos recomendados

| Modelo | Tamaño aprox. | Requiere GPU | Notas |
|---|---|---|---|
| `deepseek-r1:1.5b` | ~1–2 GB | No | Ideal para equipos sin GPU, uso general y razonamiento ligero. |
| `llama3.2:3b` | ~2 GB | No (recomendable) | Buen equilibrio tamaño/calidad. |
| `llama3.1:8b` | ~4.9 GB | Recomendada | Mejor calidad, requiere más VRAM/RAM. |
| `qwen3:4b` | ~2.5 GB | Opcional | Buen soporte de *tool calling*. |
| `whiterabbitneo-v1.5a` / `whiterabbitneo7b` | Variable | Opcional | Modelos orientados a ciberseguridad ofensiva. |

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

### Licencia

Licencia MIT (español/inglés) ampliada con cláusulas de seguridad específicas para herramientas de pruebas de penetración. Consulta el archivo [`LICENSE`](./LICENSE) para el texto completo.

###  Autor

[hackingyseguridad.com](http://www.hackingyseguridad.com/)

---

<p align="center"><i>Solo para uso legal, ético y autorizado.</i></p>
