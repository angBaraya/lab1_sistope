#!/bin/bash

# Analiza las opciones -i y -t, ambas requieren argumento
ARGS=$(getopt -o i:t: -- "$@") || exit 1

# Reorganiza los argumentos para que se puedan procesar correctamente
eval set -- "$ARGS"
# Inicializa variables para guardar los valores de -i y -t
I=""
T=""

# Bucle para procesar cada opción
while [ "$1" != "--" ]; do
  if [ "$1" = "-i" ]; then
    I="$2"       # Guarda el valor de -i
    shift 2      # Avanza dos posiciones (opción y valor)
  elif [ "$1" = "-t" ]; then
    T="$2"       # Guarda el valor de -t
    shift 2      # Avanza dos posiciones (opción y valor)
  else
    exit 1       # Si aparece una opción no reconocida, termina con error
  fi
done

# Elimina el separador "--" final
shift

# lógica del programa
SECONDS=0


while [ "$SECONDS" -lt "$T" ]; do
  timestamp=$(date --utc +"%Y-%m-%dT%H:%M:%S+00:00")

  # Ejecuta ps y recorre cada línea
  ps -eo pid=,uid=,comm=,pcpu=,pmem= --sort=-%cpu | while read -r line; do
    echo "$timestamp  $line"
  done

  echo "$timestamp  AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
  sleep "$I"
done
