#!/bin/bash

# Función para verificar si una ruta de directorio existe
verificar_ruta() {
  if [[ ! -d "$1" ]]; then
    echo "La ruta \"$1\" no es un directorio válido."
    return 1
  fi
}

# Función para generar un código aleatorio de PS4
generar_codigo_ps4() {
  local codigo
  local min=1000
  local max=9999

  codigo=$(shuf -i "$min"-"$max" -n 1)
  echo "$codigo"
}

# Limpiar la pantalla
clear

# Directorios de origen y destino
directorio_origen=""
directorio_destino=""

# Menú interactivo
echo "Menú de Configuración"
echo "---------------------"

# Solicitar la ruta de origen
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

# Solicitar la ruta de destino
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

# Solicitar el número de códigos a generar
echo "Ingrese el número de códigos que desea generar:"
read -r num_iteraciones

# Confirmación
echo "¿Desea generar $num_iteraciones códigos? (S/N):"
read -r confirmacion

if [[ "$confirmacion" != "S" && "$confirmacion" != "s" ]]; then
  echo "No se generarán códigos. Saliendo del programa."
  exit 0
fi

archivo="$directorio_destino/codigos.txt"

# Generar y guardar los códigos
for ((i=1; i<=num_iteraciones; i++))
do
  contenido=$(generar_codigo_ps4)

  if random_valido; then
    echo "Válido: $contenido"
  else
    echo "Error: $contenido"
  fi

  echo "$contenido" >> "$archivo"
done

echo "Los códigos han sido generados y guardados en el archivo $archivo correctamente."
