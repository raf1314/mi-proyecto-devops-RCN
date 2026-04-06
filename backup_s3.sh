#!/bin/bash

BUCKET_NAME="mi-bucket-devops-rcn"
DIRECTORIO="/home/cloudshell-user/mis_archivos"
BACKUP_FILE="backup_$(date +%F_%H-%M-%S).tar.gz"
LOG_FILE="backup.log"

echo "===== INICIO $(date) =====" >> $LOG_FILE

# Verificar si existe el directorio
if [ ! -d "$DIRECTORIO" ]; then
    echo "Error: el directorio no existe" >> $LOG_FILE
    exit 1
fi

# Comprimir el directorio
tar -czf $BACKUP_FILE $DIRECTORIO >> $LOG_FILE 2>&1

if [ $? -ne 0 ]; then
    echo "Error al comprimir" >> $LOG_FILE
    exit 1
else
    echo "Compresión exitosa: $BACKUP_FILE" >> $LOG_FILE
fi

# Subir a S3
aws s3 cp $BACKUP_FILE s3://$BUCKET_NAME/ >> $LOG_FILE 2>&1

if [ $? -ne 0 ]; then
    echo "Error al subir a S3" >> $LOG_FILE
    exit 1
else
    echo "Subida exitosa a S3" >> $LOG_FILE
fi

echo "===== FIN $(date) =====" >> $LOG_FILE
