# Задание 1. Модель Изинга
## Зависимости
1) meson >= 1.4.0
2) возможно, придется еще установить ninja
2) компилятор языка Vala (наверняка есть в репозиториях вашего дистрибутива, точно есть в репозиториях conda)
3) g-ir-compiler (пакет должен иметь название вроде gobject-introspection)
4) [PyGObject](https://pygobject.gnome.org/)

## Компиляция
```
$ meson build && ninja -C build       # компиляция
$ . ./add-ld-gi-pathes.sh             # добавляет пути к $LD_LIBRARY_PATH и $GI_TYPELIB_PATH
```
