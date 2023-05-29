#!/bin/bash

# Función para verificar si una ruta de directorio existe
verificar_ruta() {
  if [[ ! -d "$1" ]]; then
    echo "La ruta \"$1\" no es un directorio válido."
    return 1
  fi
}

# Función para determinar si un código es válido o no
random_valido() {
  local probabilidad_valido=2  # Probabilidad del 2% de que sea válido

  local num_random=$(( RANDOM % 100 ))

  if (( num_random < probabilidad_valido )); then
    return 0  # Código válido
  else
    return 1  # Código no válido
  fi
}

# Limpiar la pantalla
clear

# Menú interactivo
echo "Menú de Configuración"
echo "---------------------"

# Solicitar la ruta de origen
while true; do
  echo "Ingrese la ruta de origen:"
  read -r directorio_origen

  verificar_ruta "$directorio_origen" && break
done

# Solicitar la ruta de destino
while true; do
  echo "Ingrese la ruta de destino:"
  read -r directorio_destino

  verificar_ruta "$directorio_destino" && break
done

# Solicitar el número de códigos a generar
echo "Ingrese el número de códigos que desea generar:"
read -r num_iteraciones

archivo="$directorio_destino/codigos.txt"

for ((i=1; i<=num_iteraciones; i++))
do
  contenido=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
  
  if random_valido; then
    echo "Válido: $contenido"
  else
    echo "Error: $contenido"
  fi

  echo "$contenido" >> "$archivo"
  
  tiempo_espera=$(shuf -i 1-10 -n 1)
  sleep "$tiempo_espera"
done

echo "Los códigos han sido generados y guardados en el archivo $archivo correctamente."
