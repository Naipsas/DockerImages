# Imagen de la que se hereda. Repositorio de python oficial.
FROM python:2.7-slim

# Seleccionamos el directorio de trabajo para nuestra app.
WORKDIR /app

# Copiamos el directorio actual a dicho directorio. El primero es
# en el host donde estamos ejecutando esto, y el segundo es en el
# contenedor.
COPY . /app

# Instalamos dependencias necesarias en el contenedor. Las dependencias
# se escriben en el fichero requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Hacemos visible el puerto 80 del contenedor por fuera, para poder
# acceder al servicio que vamos a montar (web server).
EXPOSE 80

# Definimos una variable de entorno.
ENV welcome="Welcome to Btc Sources!"

# Ejecutamos el comando "python" con el par�metro "app.py" para lanzar
# la aplicacion cuando se haga un run al contenedor.
CMD ["python", "app.py"]