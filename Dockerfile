FROM python:3.10

# Establecer el directorio de trabajo en /app
WORKDIR /app

# Copiar el archivo de dependencias primero para aprovechar la caché
COPY requirements.txt /app/

# Instalar dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Crear y activar un entorno virtual
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Instalar dependencias dentro del entorno virtual
RUN /opt/venv/bin/pip install --upgrade pip && /opt/venv/bin/pip install --no-cache-dir -r /app/requirements.txt
RUN /opt/venv/bin/pip install --no-cache-dir pyrogram tgcrypto
RUN /opt/venv/bin/pip list
# Verificar instalación de paquetes
RUN /opt/venv/bin/pip list

# Copiar los archivos del proyecto al contenedor
COPY . /app/

# Definir el comando de inicio del contenedor
CMD ["/opt/venv/bin/python", "scr.py"]
