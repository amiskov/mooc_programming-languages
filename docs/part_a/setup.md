# Установка компилятора и настройка редактора
## Установка SML
На Маке качаем компилятор SML/NJ через Brew: `brew install smlnj`.

Теперь в терминале можно запускать команду `sml`. **[Выход через `Ctrl+D`](https://www.smlnj.org/doc/FAQ/usage.html)**, обычный `Ctrl+C` не прохляет.

## Настройка Sublime Text 3
Для комфортной работы с SML понадобиться [соответствующий Package](https://github.com/seanjames777/SML-Language-Definition#installation). Только билд по `F7` будет криво работать, если установить его через Package Control. Лучше склонировать руками:

```bash
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages
git clone https://github.com/seanjames777/SML-Language-Definition.git "SML (Standard ML)"
```

И отредактировать `sml_mac.sh` в директории `SML (Standard ML)`:

```sh
#!/bin/bash

COMMON_LOCATIONS="/opt/local/bin:/usr/bin:/opt/local/sbin:/bin:/usr/sbin:/usr/local/bin"
# Тут указать нужный путь, у меня он `/usr/local/bin/sml` (увидеть можно командой `which sml`):
SEARCH=`find /usr/local/bin/sml -type d -maxdepth 0 | sort -nr | head -n1`

PATH=$SEARCH:$COMMON_LOCATIONS:$PATH

sml "$1"
```

