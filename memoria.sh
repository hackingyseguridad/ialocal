#!/bin/bash
# Script simple para ver RAM total
# Compatible con Bash 1.0.x
# Antonio Taboada -hackingyseguridad.com

echo
echo "Total memoria RAM: "
grep "^MemTotal:" /proc/meminfo

echo ""
echo "Uso de memoria (free -m):"
free -m 2>/dev/null

echo ""
echo "Resumen vmstat:"
vmstat -s 2>/dev/null
