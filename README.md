## ialocal

---

###  IA en local,

**ialocal**  Modelos de IA en local, offline y aislados, sin conexión a Internet, scripts de instalación y arranque rápido para usar asistentes de IA (Ollama, Qwen, Claude Code, OpenCode) como apoyo en tareas de hacking ético y pentesting, sin enviar datos a la nube; Es una colección de scripts en lenguaje, bash shell linux, python3 para **Linux/Debian/Kali** que automatizan la instalación de las herramientas necesarias para tener un asistente de IA funcionando **100% en local**, con privacidad , sin depender de servicios en la nube, y usarlo como herramienta para pruebas de deteción de vulnerabilides, pruebas de concepto y explotación , en auditorías de seguridad y pruebas de penetración autorizadas, hacking.

Cuando se trabaja con datos de clientes, resultados de escaneos, IPs internas o hallazgos de una auditoría, enviar esa información a un proveedor de IA en la nube puede ser un problema de **confidencialidad** y privacidad: - Usando IA local: 

- Privacidad, ningún dato saldria de la máquina, PC donde se ejecuta la IA en local pues esta aislado, sin salida a intenret. 
- Puedes trabajar en redes locales LAN aisladas / air-gapped.
- No habria coste recurrente de API., consumo de Tokens, suelen ser modelos OpenSource.
- El rendimiento depende solo del hardware en local (funciona incluso **sin GPU**, usando modelos pequeños en CPU). Los requerimientos para ejectuar en un PC en Local, modelos de IA, son altos: se requiere GPU/CPU,  memoria RAM y velocidad de proceso.
- Menores habilidades, quiza algunos de estos modelos en local + herramientas, son menos pesados, menor tamaño o mas antiguos y tenga menos habilidades analiticas en la detección de vulnerabilidades, POC o Exploit, comparado con los ultimos  modelos enromes online, en centros de procesos de datos la nube.
- Ingragacion: Herramientas intermedias como Claude Code, OpenCode, Codex, Hermess, tienen una intergracion alta en el sistema operativo sobre el que corren.
usan las interfaces de red, LAN o WAN, ejecutan comandos y programas, uso de scripts, uso de discos y memroria para leer y guardar ficheros.
Ollama por si solo, carece de esa integración, necesitaria un Script que haga de puente con el sistema 

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
ollama run monotykamary/whiterabbitneo-v1.5a
ollama run captainkyd/whiterabbitneo7b
ollama run lazarevtill/WhiteRabbitNeo-2.5-Qwen-2.5-Coder-7B
```

También es posible integrarlo en combinacion con Claude Code como front-end, con OpenCode, Codex, con en mismo patrón de comando.

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

###  Autor

<p align="center">
  <a href="http://www.hackingyseguridad.com/">hackingyseguridad.com</a> ·
  <a href="./LICENSE">Licencia MIT + cláusulas de seguridad</a> ·
  <a href="./DISCLAMER.md">Descargo de responsabilidad</a> ·
  <a href="./CODIGODECONDUCTA.md">Código de conducta</a>
</p>
---
