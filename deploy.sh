#!/bin/bash
echo "Sincronizando archivos con S3"
aws s3 sync src/ s3://mi-bucket-devops-rcn --delete
echo "Despliegue completado"
