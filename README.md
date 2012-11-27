# Transmission Remote

## Описание
Transmission Remote - OS X клиент для торрент сервера [Transmission][transmission].

## Аудитория
Пользователи OS X, имеющие удаленное приложение [Transmission][transmission].

## Руководство
При запуске открывается основное окно: 

![Основное окно программы][mainwindow]

Для подключения к серверу необходимо настроить подключение к серверу, для этого в настройках программы (`⌘ + ,`) необходимо внести адрес сервера, порт, и учетные данные если они используются:

![Окно настроек подключения][options]

После подключения будет отображен список торрент файлов сервера, которыми можно управлять (например через контекстное меню):

![Меню управления][menu]

## Альтернативные продукты

* [transmisson-remote-gui](http://code.google.com/p/transmisson-remote-gui)
* [transmission-remote-java](http://sourceforge.net/projects/transmission-rj)

## Материалы

* [Спецификация протокола RPC][rpcspec]
* Были использованы некоторые ресурсы из официального приложения [Transmission][transmission] (доступны по лицензии MIT).

[transmission]: http://transmissionbt.com
[mainwindow]: https://raw.github.com/TurchenkoAlex/osx-project-2/master/screenshots/mainwindow.png
[menu]: https://raw.github.com/TurchenkoAlex/osx-project-2/master/screenshots/menu.png
[options]: https://raw.github.com/TurchenkoAlex/osx-project-2/master/screenshots/options.png
[rpcspec]: https://raw.github.com/TurchenkoAlex/osx-project-2/master/rpc-spec.txt