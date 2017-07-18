# Неделя III
* Создаем свои типы и работаем с ними:
* составные данные
* pattern matching
* Исключения
* Хвостовая рекурсия

## Building Compound Types
* Basic types: int, char, real, unit
* Compound type: tuples, lists, options

В любом языке есть 3 строительных блока для составных типов:
* `Each of`: тип `t` представляется каждым из типов `t1, t2, ..., tn`. Например, координата точки (`x`, `y`, `z`) или имя и фамилия (имя - `t1`, фамилия - `t2`).
* `One of`: `t` может быть какого-то одного типа: или `t1` или `t2` или `tn`. Например, статус принтера. Он может или печатать, или глючить, или зажевать бумагу. Сразу во всех статусах он быть не может.
* `Self reference`: `list` может содержать другой `list`, это надо учесть (рекурсивная структура данных).

Очень многие структуры данных можно описать этими тремя способами.

### Примеры
* Typles — each of: `(int * bool)` — кортеж (пара) число и булево значение.
* Option — one of: `int option` — или число или пустота.
* List — использует все 3 способа. `int list` может содержат числа, списки чисел или не содержать ничего.
* Можно наследовать составные типы: `((int * int) option * (int list list)) option`.

Records — как Typles, но вместо `#1` и `#2` у них есть именованные поля. Как кортежи с синтаксическим сахаром. Для собственных данных типа `each of`.

Можно сделать свой one of. Например, тип может содержать `int` или `string`. + pattern matching.

ООП делает one of type по-другому (через подтипы и подклассы). Разобрать отличие между ФП и ООП в этом плане — одна из ключевых задач курса.

## Records
Составной тип данных, представляет собой `each of` type.

Порядок полей в Record не имеет значения. При выводе REPL их сортирует по алфавиту.

```sml
val x = {bar=(3,true),baz=(false,9),foo=7}
(* : {bar:int * bool, baz:bool * int, foo:int} *)

#bar x; (* достать значение из `x` *)
```

Тип `x` будет такой: `val it = {bar=(3,true),baz=(false,9),foo=7}`.

В кортежах важна последовательность: `(4, 7, 9)`, в записях (Records) все по именам, более наглядно.

## Tuples as Syntactic Sugar
На самом деле в ML есть записи, а кортежи – это частный случай записей с ключами-цифрами по порядку:

```sml
val x = {1=3+2, 3=7, 2=true};
(* val x = (5,true,7) : int * bool * int — котеж *)
```

## Datatype Bindings
Создание своего типа данных:

```sml
datatype mytype = 
    TwoInts of int * int 
    | Str of string
    | Pizza

val x = TwoInts(2, 3); (* Конструктор – с большой буквы (соглашение) *)

(* TwoInts — tag union (вариант, ветка паттерн-матчинга); (2, 3) — corresponding data *)

val y = Str("hello");
val z = Pizza; (* без `of [sometype]` это просто value типа mytype, не конструктор *)
```

Получили one of type: может быть 1-м из трех. `mytype` может быть получен с помощью одного из трех конструкторов.

Так создаются типы данных. Теперь нужно как-то получать данные:
* Проверить, какой конструктор их создал
* Извлечь данные

## Case Expressions
См. `case.sml`.

Multibranch conditional. Как `switch/case`.

## Type Synonyms
```sml
datatype suit = Club | Diamond | Heart | Spade
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank (* Чтоб не писать `suit * rank` *)
```

## Lists and Options are Datatypes
В Options `NONE` и `SOME` — конструкторы, их можно использовать в `case...of`:

```sml
fun inc_or_zero intoption =
    case intoption of
        NONE => 0
      | SOME i => i + 1
```

В списках `[]` и `::` — конструкторы. `[]` — пустой список (вместо `null`, `::` — не пустой (вместо `hd` и `tl`):

```sml
fun sum_list xs =
    case xs of
        [] => 0
      | x::xs' => x + sum_list xs';
```

## Polymorphic Datatypes
Списки (list) на самом деле имеют тип `'a list` (альфа-лист). И уже при объявлении они становятся `int list`, `string list` и т. д. То есть `list` это такая фабрика типов.

## Each of Pattern Matching / Truth About Functions
Паттерн-матчинг позволяет обойтись без явного указания типов. При сопоставлении тайп-чекер сам все поймет:

```sml
fun sum_triple3 (x, y, z) = x + y + z;
fun full_name3 {first=x, middle=y, last=z} = x ^ " " ^ y ^ " " ^z;

val x = sum_triple3(1, 2, 3);
val y = full_name3({first="Andrey", middle="Y.", last="Miskov"});
```

Функции в ML принимают **только один аргумент** и потом используют паттерн-матчинг. Такая запись: `fun sum_triple(x, y, z)` принимает и кортеж из трех элементов и это выглядит типа как аргументы функции. На самом деле функция всегда принимает только один аргумент и у него уже есть свой тип.

Даже функция `fun hello() = ...` принимает 1 аргумент. Тип `unit`.

## A Little Type Inference
Можно делать так:

```sml
fun partial_sum (x, y, z) = 
    x + z (* `y` не используется, это нормально *)
```

Т. к. `y` не используется, ML дает ему тип `'a` (альфа) и мы можем передавать вторым аргументом (на самом деле вторым элементом кортежа, т. к. в функциях всего 1 аргумент) значение любого типа. Unexpected polymorphism.

## Polymorphic and Equality Types
ML не дает сравнивать `real`-числа с помощью равенства. `real` is not an equality type. [Тут](http://sml-family.org/Basis/real.html) внизу есть рассуждения на эту тему.

```sml
(* has type ''a * ''a -> string *)
fun same_thing(x,y) = if x=y then "yes" else "no" 
```

Так тайп-чекер не поймет, какой тип будет передаваться. Он скажет `Warning: calling polyEqual`. Передано может быть что угодно и ты рискуешь сравнивать, например, строку с интом, что повлечет ошибку.

## Nested Patterns


## More Nested Patterns
```sml
fun nondecreasing xs =
    case xs of
    [] => true
      | _::[] => true
      | head::(neck::rest) => (head <= neck andalso nondecreasing (neck::rest))
```

`head::(neck::tail)` matches list witn 2 or more elements.

`_::[] => true` — если справа от `=>` переменная не используется, то принято ее обозначать `_`.

Хороший стиль кода:
* Избегать вложенных `case ... of`. Лучше использовать больше бранчей на первом уровне с вложенным pattern matching. См. `unzip3`, `nondecreasing`.
* Часто полезно делать матчинг на кортежах. См. `zip3`, `multsign`.
* Wildcards instead of variables (использовать `_`, если переменная справа от `=>` не используется). См. `len`, `multsign`.

## Nested Patterns Precisely

## Function Patterns

## Exceptions

## Tail Recursion
Надо аккуратно с рекурсивными аппендами. Там хвостовая оптимизация критична.

## Perspective on Tail Recursion
При обработке деревьев хвостовая оптимизация не даст преимущества. Все равно надо где-то сохранять данные, а это соизмеримо с заполнением стэка.

