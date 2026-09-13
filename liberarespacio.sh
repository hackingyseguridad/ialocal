#!/bin/sh
# ======================================================
# Script: limpieza maxima bash Shell en sistema Linux
# Descripcion: Limpieza agresiva para liberar espacio
# Compatible: Bash 1.0.x / sh antiguo
# ======================================================

echo ""
echo "=== LIMPIEZA MAXIMA DE ESPACIO EN LINUX ==="
echo ""

# Funcion para mostrar espacio antes/despues
mostrar_espacio() {
    echo "Espacio en /:"
    df -h / | grep -v "Filesystem"
}

# Mostrar espacio inicial
echo "[*] Espacio antes de limpiar:"
mostrar_espacio
echo ""

# 1. LIMPIAR CACHE DE USUARIO (si existe)
echo "[1] Limpiando cache de usuario..."
if [ -d "$HOME/.cache" ]; then
    rm -rf $HOME/.cache/* 2>/dev/null
    echo "    - Cache de usuario limpiado"
fi

if [ -d "$HOME/.thumbnails" ]; then
    rm -rf $HOME/.thumbnails/* 2>/dev/null
    echo "    - Miniaturas eliminadas"
fi

# 2. LIMPIAR HISTORIALES DE COMANDOS
echo "[2] Limpiando historiales..."
for HIST in $HOME/.bash_history $HOME/.zsh_history $HOME/.python_history; do
    if [ -f "$HIST" ]; then
        rm -f "$HIST" 2>/dev/null
        echo "    - Eliminado: $HIST"
    fi
done

# 3. LIMPIAR DIRECTORIOS TEMPORALES
echo "[3] Limpiando temporales..."
if [ -d "/tmp" ]; then
    rm -rf /tmp/* 2>/dev/null
    echo "    - /tmp limpiado"
fi

if [ -d "/var/tmp" ]; then
    rm -rf /var/tmp/* 2>/dev/null
    echo "    - /var/tmp limpiado"
fi

# 4. LIMPIAR CACHE DE APT (si existe)
if command -v apt-get >/dev/null 2>&1; then
    echo "[4] Limpiando cache de APT..."
    apt-get clean 2>/dev/null
    apt-get autoclean 2>/dev/null
    rm -rf /var/cache/apt/archives/*.deb 2>/dev/null
    echo "    - Cache APT limpiado"
fi

# 5. LIMPIAR CACHE DE DNF/YUM (si existe)
if command -v dnf >/dev/null 2>&1; then
    echo "[5] Limpiando cache de DNF..."
    dnf clean all 2>/dev/null
    echo "    - Cache DNF limpiado"
elif command -v yum >/dev/null 2>&1; then
    echo "[5] Limpiando cache de YUM..."
    yum clean all 2>/dev/null
    echo "    - Cache YUM limpiado"
fi

# 6. LIMPIAR LOGS ANTIGUOS
echo "[6] Limpiando archivos de log..."
# Vaciar logs del sistema
if [ -d "/var/log" ]; then
    find /var/log -type f -name "*.log" -exec cp /dev/null {} \; 2>/dev/null
    find /var/log -type f -name "*.log.*" -exec rm -f {} \; 2>/dev/null
    find /var/log -type f -name "*.gz" -exec rm -f {} \; 2>/dev/null
    echo "    - Logs del sistema vaciados"
fi

# 7. ELIMINAR PAQUETES HUERFANOS
echo "[7] Eliminando paquetes huerfanos..."
if command -v deborphan >/dev/null 2>&1; then
    deborphan | xargs apt-get -y remove --purge 2>/dev/null
    echo "    - Paquetes huerfanos eliminados"
fi

# 8. LIMPIAR CACHE DE PIP (Python)
if [ -d "$HOME/.cache/pip" ]; then
    echo "[8] Limpiando cache de pip..."
    rm -rf $HOME/.cache/pip/* 2>/dev/null
    echo "    - Cache pip limpiado"
fi

# 9. ELIMINAR NUCLEOS ANTIGUOS (solo Debian/Ubuntu)
if command -v dpkg >/dev/null 2>&1; then
    echo "[9] Eliminando kernels antiguos..."
    # Obtener kernel actual
    ACTUAL=$(uname -r)
    # Listar kernels instalados (excluyendo el actual)
    dpkg -l | grep linux-image- | grep -v "$ACTUAL" | awk '{print $2}' | while read -r KERNEL; do
        echo "    - Eliminando: $KERNEL"
        apt-get -y purge "$KERNEL" 2>/dev/null
    done
fi

# 10. LIMPIAR BASURA DEL SISTEMA
echo "[10] Limpiando archivos basura..."
# Archivos core dump
find / -type f -name "core.*" -exec rm -f {} \; 2>/dev/null
find / -type f -name "*.core" -exec rm -f {} \; 2>/dev/null
# Archivos temporales de editores
find / -type f -name "*~" -exec rm -f {} \; 2>/dev/null
find / -type f -name "*.swp" -exec rm -f {} \; 2>/dev/null
find / -type f -name ".DS_Store" -exec rm -f {} \; 2>/dev/null

# 11. VACIAR PAPELERA
echo "[11] Vaciando papelera..."
if [ -d "$HOME/.local/share/Trash" ]; then
    rm -rf $HOME/.local/share/Trash/* 2>/dev/null
    echo "    - Papelera vaciada"
fi

# 12. LIMPIAR JOURNALD (si existe)
if command -v journalctl >/dev/null 2>&1; then
    echo "[12] Limitando logs de journald..."
    journalctl --rotate 2>/dev/null
    journalctl --vacuum-time=1s 2>/dev/null
    echo "    - Journald limpiado"
fi

echo ""
echo "=== LIMPIEZA COMPLETADA ==="
echo ""
echo "[*] Espacio despues de limpiar:"
mostrar_espacio
echo ""

# Resumen final
echo "[+] Resumen de espacio recuperado:"
echo "    Revisa df -h para detalles"
echo ""
echo
echo "Buscando archivos mayores de 500MB..."

find / -type f -size +500M 2>/dev/null

echo ""
printf "¿Eliminar archivos encontrados? (s/n): "
read RESP

if [ "$RESP" = "s" ] || [ "$RESP" = "S" ]; then

    find / -type f -size +500M 2>/dev/null | while read FILE
    do
        echo "Borrando: $FILE"
        rm -f "$FILE"
    done

    echo "Limpieza completada"

else
    echo "Cancelado"
fi

