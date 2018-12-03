# Imagen FINAL
FROM python:3.5-slim

MAINTAINER Btc Sources "btcsourcesweb@gmail.com"

# Seleccionamos el directorio de trabajo para nuestra app.
WORKDIR /app

# Copiamos el directorio actual a dicho directorio. El primero es
# en el host donde estamos ejecutando esto, y el segundo es en el
# contenedor.
COPY ./TelegramBots/ChapterNotifier/ /app/
COPY ./requirements.txt /app/requirements.txt

# Instalamos dependencias necesarias en el contenedor. Las dependencias
# se escriben en el fichero requirements.txt
RUN pip install --trusted-host pypi.python.org -r ./requirements.txt

# Definimos una variable de entorno.
# ENV welcome="Welcome to Btc Sources!"

# Ejecutamos el comando "python" con el parámetro "app.py" para lanzar
# la aplicacion cuando se haga un run al contenedor.
CMD ["python", "/app/ChapterNotifier.py"]