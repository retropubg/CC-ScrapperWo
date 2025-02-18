FROM python:3.10

# Establecer el directorio de trabajo en /app
WORKDIR /app

# Copiar los archivos del proyecto al contenedor
COPY . /app/

# Instalar dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Crear y activar un entorno virtual
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Actualizar pip e instalar dependencias
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Definir el comando de inicio del contenedor
CMD ["python", "scr.py"]
