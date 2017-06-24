# Part A Tips and Tricks
## Как вызвать функцию в файле, чтоб проверить?
В ML функцию нельзя просто так взять и вызвать. Функция в ML должна что-то вернуть и это что-то нужно куда-то сохранить. Поэтому так:

```ml
fun append(xs : int list, ys : int list) = 
    if null xs
    then ys
    else (hd xs) :: append((tl xs), ys)

val a = append([1, 2, 3], [4, 5, 6]);
```

## List Functions
Когда мы суммируем элементы списка, то получается:

```ml
fun sum_list(xs : int list) =
    if null xs
    then 0 (* возвращаем 0 на пустом списке *)
    else hd xs + sum_list(tl xs)

val sum = sum_list([1, 2, 3])
```

Если сразу после этой задачи сказать "реализуйте аналогичным образом умножение элементво списка", то можно напороться на то, что все время будет 0. Это потому, что на `null xs` надо возвращать `1`:

```ml
fun list_product(xs : int list) =
    if null xs
    then 1 (* не 0, потому что в конце идет умножение, а не сложение *)
    else hd xs * list_product(tl xs)

val product = list_product([2, 3, 4])
```

## Подключение модулей
Если в файле `module2.sml` подключить файл `module1.sml`:

```sml
(* module2.sml *)
use "module1.sml";

module1_func();
```

то в третьем файле `module3.sml`, который подключает `module2.sml` будет ошибка:

```sml
(* module3.sml - wrong *)
use "module2.sml"; (* Fatal error *)

module1_func();
module2_func();
```

Нужно только 1 раз подключать модуль. То есть все нужно подключать в 3-м:

```sml
(* module3.sml - ok *)
use "module1.sml";
use "module2.sml";

module1_func();
module2_func();
```

## Бесконечная рекурсия
Если написать бесконечную рекурсию:

```sml
fun range(x1 : int, x2 : int) = 
    if x1 > x1 (* ошибка, должно быть x1 > x2 *)
    then []
    else x1::range(x1 + 1, x2)
```

То компилятор будет ее гонять бесконечно. Зашумит кулер, но никакого сообщения о переполнении стэка не будет. И даже после остановки `sml` в консоли процессор пожирался, приходилось перезагружать машину.
