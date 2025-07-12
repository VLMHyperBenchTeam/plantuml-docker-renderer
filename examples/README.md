# Примеры использования PlantUML Docker Renderer

Эта папка содержит примеры для тестирования и демонстрации работы PlantUML Docker Renderer.

## Содержимое

- `sample.puml` - Пример PlantUML диаграммы для тестирования рендерера

## Тестирование

### Локальное тестирование

```bash
# Перейти в папку examples
cd examples

# Рендеринг примера в SVG
export MOUNT_POINT="/workspace"
docker run --rm -v $(pwd):$MOUNT_POINT ghcr.io/vlmhyperbenchteam/plantuml-renderer:latest $MOUNT_POINT svg

# Рендеринг примера в PNG
docker run --rm -v $(pwd):$MOUNT_POINT ghcr.io/vlmhyperbenchteam/plantuml-renderer:latest $MOUNT_POINT png
```

### Ожидаемый результат

После выполнения команд должны появиться файлы:
- `sample.svg` - векторное изображение диаграммы
- `sample.png` - растровое изображение диаграммы

## Структура диаграммы

Пример `sample.puml` демонстрирует:
- Использование акторов и участников
- Последовательность действий
- Добавление заметок
- Настройку темы и параметров отображения 