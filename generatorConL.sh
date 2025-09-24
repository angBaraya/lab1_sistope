#!/bin/bash

# Analiza las opciones -i, -t y -l, todas requieren argumento
ARGS=$(getopt -o i:t:l: -- "$@") || exit 1

# Reorganiza los argumentos para que se puedan procesar correctamente
eval set -- "$ARGS"

# Inicializa variables
I=""
T=""
L=""

# Procesa cada opción
while [ "$1" != "--" ]; do
  if [ "$1" = "-i" ]; then
    I="$2"
    shift 2
  elif [ "$1" = "-t" ]; then
    T="$2"
    shift 2
  elif [ "$1" = "-l" ]; then
    L="$2"
    shift 2
  else
    exit 1
  fi
done

# Crea el directorio si no existe
mkdir -p "$(dirname "$L")"

# Lógica principal
SECONDS=0
while [ "$SECONDS" -lt "$T" ]; do
  timestamp=$(date --utc +"%Y-%m-%dT%H:%M:%S+00:00")

  # Recorre cada línea del comando ps y la escribe con timestamp
  ps -eo pid=,uid=,comm=,pcpu=,pmem= --sort=-%cpu | while read -r line; do
    echo "$timestamp  $line" >> "$L"
  done

  # Mensaje personalizado
  echo "$timestamp  AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" >> "$L"

  # Espera el intervalo indicado
  sleep "$I"
done

