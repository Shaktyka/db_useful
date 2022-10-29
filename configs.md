# Конфигурация сервера

Управление работой и поведением сервера.

Основной файл: `postgresql.conf`
Представление: `pg_file_settings` - показывает значения из файла conf

Каталог с данными PGDATA - по умолчанию.

Каталог при сборке из пакетов: `/etc/postgresql/13/main`

При изменении параметров нужно перечитать файл:

`pg_ctl reload` - для постгреса, собранного из исходных кодов

`pg_cltcluster 13 main reload`

`SELECT pg_reload_conf();`

Некоторые параметры сервера требуют перезапуска сервера.

Каталог и название основного конфиг. файла:

`SHOW config_file;`

## Какие значения действительно установлены

Представление `pg_settings` - все параметры сервера + служ. информация

postmaster - нужно перезапустить сервер
sighup - нужно перечитать значения настроек

```
SELECT
    sourceline, name, setting, applied
FROM pg_file_settings
WHERE name = 'work_mem'
```

Чтобы изменения вступили в силу, нужно перечитать конфигурации:

```
SELECT pg_reload_conf();
```

## postgresql.auto.conf

Редактируется с помощью ALTER SYSTEM.
Считывается после `postgresql.conf`. Всегда каталога PPGDATA.
Перечитать конфиг-цию либо перестартовать сервер.
Это SQL-интерфейс для редактирования конфигураций.

```
ALTER SYSTEM
SET параметр TO значение;
```

```
ALTER SYSTEM 
RESET параметр;
```

```
SELECT pg_read_file('postgresql.auto.conf') \g
```

Перечитать конфигурацию:

```
SELECT pg_reload_conf();
```

## В текущем сеансе

Для параметров, отмеченных как user и superuser.

`SET, set_config` - запись

`SHOW <name>, current_setting(<name>)` - чтение

До конца сеанса или транзакции.
Установка параметров транзакционна.
Допускаются польз-кие параметры (наличие точки внутри).

```
SELECT set_config('work_mem', '32MB', false);
```
