# Аутентификация с GitHub Container Registry на Windows

Полная документация проекта доступна в [README.md](../README.md).

## Проблема

При попытке загрузить Docker образ из GitHub Container Registry (GHCR) на Windows PowerShell возникает ошибка доступа:

```powershell
docker pull ghcr.io/vlmhyperbenchteam/plantuml-renderer:latest
Error response from daemon: error from registry: denied
```

При этом:
- Репозиторий является публичным
- Пользователь успешно прошел аутентификацию через `gh auth login`
- На Linux системах тот же образ загружается без проблем

## Причина проблемы

Проблема возникает из-за различий в управлении учетными данными между Docker и GitHub CLI на Windows:

1. **Раздельное хранение учетных данных**: Docker и GitHub CLI хранят учетные данные независимо друг от друга
2. **Кэширование старых учетных данных**: Docker может использовать старые или невалидные учетные данные из кэша
3. **Разные методы аутентификации**: Даже при успешной аутентификации через GitHub CLI, Docker Registry может требовать отдельную аутентификацию

## Решение

### Шаг 1: Выход из системы Docker Registry

Сначала необходимо выйти из системы для GitHub Container Registry, чтобы очистить старые учетные данные:

```powershell
docker logout ghcr.io
```

### Шаг 2: Аутентификация через GitHub CLI

Выполните аутентификацию через GitHub CLI:

```powershell
gh auth login
```

Следуйте инструкциям в консоли:
1. Выберите "GitHub.com"
2. Выберите "HTTPS" как протокол для Git операций
3. Подтвердите аутентификацию GitHub учетными данными
4. Выберите "Login with a web browser" для аутентификации

### Шаг 3: Аутентификация в Docker Registry

Используйте токен из GitHub CLI для аутентификации в Docker Registry:

```powershell
$env:CR_PAT = gh auth token; echo $env:CR_PAT | docker login ghcr.io -u medphisiker --password-stdin
```

Эта команда:
- Получает токен аутентификации из GitHub CLI с помощью `gh auth token`
- Сохраняет его во временную переменную окружения `$env:CR_PAT`
- Передает токен в команду `docker login` через `echo` и пайп

### Шаг 4: Проверка загрузки образа

Теперь можно успешно загрузить образ:

```powershell
docker pull ghcr.io/vlmhyperbenchteam/plantuml-renderer:latest
```

## Альтернативные решения

### Решение 1: Использование переменной GITHUB_TOKEN

Если у вас уже есть настроенный `GITHUB_TOKEN`, можно использовать его напрямую:

```powershell
echo $env:GITHUB_TOKEN | docker login ghcr.io -u medphisiker --password-stdin
```

### Решение 2: Создание персонального токена доступа

1. Перейдите в Settings → Developer settings → Personal access tokens
2. Создайте новый токен с правами `read:packages`
3. Используйте его для аутентификации:

```powershell
$token = "ваш_токен"
echo $token | docker login ghcr.io -u medphisiker --password-stdin
```

## Профилактика

Чтобы избежать подобных проблем в будущем:

1. **Регулярно обновляйте учетные данные**: Периодически выполняйте `docker logout` и повторяйте аутентификацию
2. **Используйте скрипты для аутентификации**: Создайте PowerShell скрипт для автоматической аутентификации
3. **Проверяйте настройки пакета**: Убедитесь, что пакет в GitHub Container Registry имеет правильные настройки видимости

## Дополнительная информация

- Документация GitHub по аутентификации: [Authenticating to GitHub Packages](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-to-the-container-registry)
- GitHub CLI документация: [gh auth login](https://cli.github.com/manual/gh_auth_login)