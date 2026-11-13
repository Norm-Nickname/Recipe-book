# Recipe Book

Учебное Flutter-приложение «Кулинарная книга» на данных открытого API
[TheMealDB](https://www.themealdb.com/api.php). Выполнено в рамках курса
«Кроссплатформенные средства разработки программного обеспечения» (лабораторные
работы №1–5).

## Возможности

- список рецептов, полученный с сервера (первый запрос);
- экран детальной информации о рецепте с загрузкой по `id` (второй запрос);
- управление состоянием на BLoC (`flutter_bloc`);
- внедрение зависимостей через `get_it`;
- навигация через `go_router`;
- логирование HTTP-запросов и событий BLoC через `talker`;
- pull-to-refresh, обработка ошибок и повторная загрузка;
- просмотр логов приложения из интерфейса (иконка жука в AppBar).

## Скриншоты

| Главный экран | Экран деталей |
| --- | --- |
| ![Главный экран](docs/screenshots/home.png) | ![Экран деталей](docs/screenshots/details.png) |

## Документация

Отчёты по лабораторным работам №2–5 находятся в папке курса (`Lab_2025`):
«Отчёт_ЛР2_Верстка_часть1.docx», «Отчёт_ЛР3_Верстка_часть2.docx»,
«Отчёт_ЛР4_API_и_BLoC_часть1.docx», «Отчёт_ЛР5_API_и_BLoC_часть2.docx».

## API

Базовый адрес: `https://www.themealdb.com/api/json/v1/1`

| Назначение | Метод | Параметры |
| --- | --- | --- |
| Список рецептов | `/search.php` | `s=` |
| Рецепт по id | `/lookup.php` | `i={idMeal}` |

Тестовый ключ `1` уже входит в базовый адрес, регистрация не требуется.

## Структура проекта

```
lib/
├── main.dart                     // точка входа
├── name.dart                     // корневой виджет приложения
├── di/di.dart                    // get_it, Dio, talker
├── data/
│   ├── dio/                      // настройка Dio и endpoints
│   ├── models/                   // модель Meal (+ meal.g.dart)
│   └── repositories/             // интерфейс и реализация репозитория
└── app/
    ├── extensions/               // вспомогательные расширения
    ├── features/
    │   ├── home/                 // первый экран + HomeBloc
    │   └── content/              // второй экран + ContentBloc
    ├── router/                   // go_router
    ├── theme/                    // цвета и ThemeData
    └── widgets/                  // общие виджеты
```

## Запуск

```bash
flutter pub get
flutter run
```

Если менялась модель данных, кодогенерация запускается командой:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Зависимости

`go_router`, `get_it`, `talker`, `talker_flutter`, `dio`, `equatable`,
`flutter_bloc`, `talker_dio_logger`, `talker_bloc_logger`, `json_annotation`;
для кодогенерации — `build_runner`, `json_serializable`.
