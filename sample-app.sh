#!/bin/bash
# Eliminar el directorio tempdir si ya existe
rm -rf tempdir  

# Crear el directorio temporal y sus subdirectorios
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

# Copiar el archivo de la aplicación y sus recursos estáticos
cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

# Crear el archivo Dockerfile en el directorio temporal
echo "FROM python" >> tempdir/Dockerfile
echo "RUN pip install flask gunicorn" >> tempdir/Dockerfile   # Instalar Flask y Gunicorn
echo "COPY ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY sample_app.py /home/myapp/" >> tempdir/Dockerfile

# Establecer el directorio de trabajo dentro del contenedor
echo "WORKDIR /home/myapp" >> tempdir/Dockerfile

# Exponer el puerto 5050 para la aplicación
echo "EXPOSE 5050" >> tempdir/Dockerfile

# Usar Gunicorn para ejecutar la aplicación con 4 trabajadores
# Gunicorn escucha en el puerto 5050, vinculando a la dirección 0.0.0.0 (todas las interfaces)
echo "CMD gunicorn -w 4 -b 0.0.0.0:5050 sample_app:sample" >> tempdir/Dockerfile

# Cambiar al directorio temporal
cd tempdir

# Construir la imagen de Docker
docker build -t sampleapp .

# Ejecutar el contenedor, mapeando el puerto 5050 del host al puerto 5050 del contenedor
docker run -t -d -p 5050:5050 --name samplerunning sampleapp

# Mostrar la lista de contenedores
docker ps -a
