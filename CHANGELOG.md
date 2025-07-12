# Changelog

Все значимые изменения в этом проекте будут документированы в этом файле.

Формат основан на [Keep a Changelog](https://keepachangelog.com/ru/1.0.0/),
и этот проект придерживается [Semantic Versioning](https://semver.org/lang/ru/).

## [Планируется] v0.1.0 - Первый релиз PlantUML Docker рендерера

### Добавлено
- Docker образ для рендеринга PlantUML диаграмм
- Python скрипт для пакетного рендеринга .puml файлов
- Поддержка форматов SVG и PNG
- Настраиваемая точка монтирования через переменную MOUNT_POINT
- Подробное логирование процесса рендеринга
- Обработка ошибок с информативными сообщениями
- GitHub Actions CI/CD для автоматической сборки и публикации
- Публикация в GitHub Container Registry (`ghcr.io/vlmhyperbenchteam/plantuml-renderer`)
- Подробная документация с примерами использования
- Интеграция в основной проект как git submodule

### Технические детали
- Базовый образ: `plantuml/plantuml:latest`
- Поддерживаемые форматы: SVG, PNG
- Автоматический поиск всех .puml файлов в указанной директории
- Сохранение структуры папок при рендеринге
- Валидация входных параметров
- Обработка ошибок PlantUML

### Структура проекта
```
plantuml-docker-renderer/
├── Dockerfile
├── render_plantuml.py
├── README.md
├── examples/
│   ├── sample.puml
│   └── README.md
├── .github/workflows/docker-publish.yml
├── .gitignore
├── LICENSE
└── CHANGELOG.md
``` 