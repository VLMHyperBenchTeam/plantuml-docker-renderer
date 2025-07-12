# Dockerfile для рендеринга PlantUML диаграмм в SVG и PNG
# Основан на официальном PlantUML Docker образе

FROM plantuml/plantuml:latest

# Устанавливаем дополнительные зависимости для работы с файлами
RUN apt-get update && apt-get install -y \
    bash \
    findutils \
    grep \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Python
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Создаем рабочую директорию
WORKDIR /workspace

# Копируем Python-скрипт
COPY render_plantuml.py /usr/local/bin/render_plantuml.py

# Устанавливаем точку входа
ENTRYPOINT ["python3", "/usr/local/bin/render_plantuml.py"] 