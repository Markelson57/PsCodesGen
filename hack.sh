#!/bin/bash


verificar_ruta() {
  if [[ ! -d "$1" ]]; then
    echo "La ruta \"$1\" no es un directorio válido."
    return 1
  fi
}


random_valido() {
  local probabilidad_valido=2  

  local num_random=$(( RANDOM % 100 ))

  if (( num_random < probabilidad_valido )); then
    return 0  
  else
    return 1  
  fi
}


clear


directorio_origen=""
directorio_destino=""


echo "Menú de Configuración"
echo "---------------------"


while true; do
  echo "Ingrese la ruta de origen (deje en blanco para crear automáticamente en el escritorio):"
  read -r directorio_origen

  if [[ -z "$directorio_origen" ]]; then
    directorio_origen="$HOME/Desktop/origen"
    mkdir -p "$directorio_origen"
    echo "Se ha creado el directorio de origen en \"$directorio_origen\"."
    break
  fi

  verificar_ruta "$directorio_origen" && break
done


while true; do
  echo "Ingrese la ruta de destino (deje en blanco para crear automáticamente en el escritorio):"
  read -r directorio_destino

  if [[ -z "$directorio_destino" ]]; then
    directorio_destino="$HOME/Desktop/destino"
    mkdir -p "$directorio_destino"
    echo "Se ha creado el directorio de destino en \"$directorio_destino\"."
    break
  fi

  verificar_ruta "$directorio_destino" && break
done


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
