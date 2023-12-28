#!/bin/bash

# Directorio a respaldar (directorio raíz)
DIRECTORIO_ROOT="/"

# Carpeta a excluir del respaldo
EXCLUIR_CARPETA="backup_pentaho"

# Directorio de respaldo
BACKUP_DIRECTORIO="/backup_pentaho"

# Nombre del archivo de respaldo (con marca de tiempo)
BACKUP_ARCHIVO="$BACKUP_DIRECTORIO/backup_$(date +\%Y\%m\%d_\%H\%M\%S).tar.gz"

# Archivo de registro
LOG_FILE="/backup_pentaho/logs/logfile_$(date +\%Y\%m\%d).log"
k
# Verificar si el directorio fuente existe
if [ -d "$DIRECTORIO_ROOT" ]; then
    # Crear el directorio de respaldo si no existe
    mkdir -p "$BACKUP_DIRECTORIO"

    # Realizar el respaldo y comprimir usando tar, excluyendo la carpeta especificada
    sudo tar czvf "$BACKUP_ARCHIVO" --exclude="$DIRECTORIO_ROOT/$EXCLUIR_CARPETA" "$DIRECTORIO_ROOT" 2>> "$LOG_FILE"

    # Verificar si la operación fue exitosa
    if [ $? -eq 0 ]; then
        # Registrar la operación en el archivo de registro
        echo "$(date +\%Y\%m\%d_\%H\%M\%S): Respaldo de $DIRECTORIO_ROOT realizado con éxito. Archivo comprimido: $BACKUP_ARCHIVO" >> "$LOG_FILE"

        echo "Respaldo completado. Archivo comprimido: $BACKUP_ARCHIVO"
    else
        # Registrar en el archivo de registro si hubo un error en el respaldo
        echo "$(date +\%Y\%m\%d_\%H\%M\%S): Error - No se pudo realizar el respaldo de $DIRECTORIO_ROOT." >> "$LOG_FILE"

        echo "Error - No se pudo realizar el respaldo de $DIRECTORIO_ROOT."
    fi
else
    # Registrar en el archivo de registro si el directorio fuente no existe
    echo "$(date +\%Y\%m\%d_\%H\%M\%S): Error - El directorio fuente $DIRECTORIO_ROOT no existe." >> "$LOG_FILE"

    echo "Error - El directorio fuente $DIRECTORIO_ROOT no existe."
fi
