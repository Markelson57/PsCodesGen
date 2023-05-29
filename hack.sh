#!/bin/bash

# Función para verificar si una ruta de directorio existe
verificar_ruta() {
  if [[ ! -d "$1" ]]; then
    echo "La ruta \"$1\" no es un directorio válido."
    return 1
  fi
}

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

archivo="codigos.txt"

for ((i=1; i<=num_iteraciones; i++))
do
  contenido=$(cat /dev/urandom | tr -dc 'A-Z0-9' | fold -w 12 | head -n 1)
  
  if [ $i -eq 34 ]; then
    echo "Válido: $contenido"
  else
    echo "Error: $contenido"
  fi

  echo "$contenido" > "$directorio_origen/$archivo"
  cp "$directorio_origen/$archivo" "$directorio_destino/$archivo_$i" >/dev/null 2>&1
  
  tiempo_espera=$(shuf -i 1-10 -n 1)
  sleep "$tiempo_espera"
done

echo "Los códigos han sido generados y guardados en el directorio de destino correctamente."
