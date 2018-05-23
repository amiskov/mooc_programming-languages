# Неделя I

## Introduction to Racket
Нет статической типизации, возможны ошибки на этапе исполнения. В ML такого не бывает.

Racket похож на Scheme, пошел от него. Синтаксис минималистичен, много скобочек для группировки, зато меньше синтаксических конструкций. Подробнее про Ракет можно почитать в [The Racket Guide](https://docs.racket-lang.org/guide/).

Все в Racket — выражение. Не нужно делать `return`, он как бы по умолчанию.

В Racket каждый файл — модуль и все внутри него приватно. Нужно самому указывать, что открывать вовне. Но есть способ сделать все публичным:

```scheme
(provide (all-defined-out))
```

## Racket Definitions, Functions, Conditionals
Определение переменных (binding):

```scheme
(define x 3)
(define y (+ x 2)) ; вызо функции `+` — скобки, имя функции и параметры
```

Пример функции:

```scheme
(define cube ; создали переменную, забайндили на анонимную функцию:
  (lambda (x) (* x x x)))

; Можно так, это синтаксический сахар:
(define (cube x)
  (* x x x))

; Вызов с выводом на экран:
(display (cube 3))
```

Функция принимает столько аргументов, сколько передано, не так, как в ML, где аргумент всегда 1. Можно создавать ф-и, принимающие произвольное кол-во аргументов, как умножение `(* x y z ...)`.

В Лиспах принято назвать идентификаторы (переменные, функции и пр.) через `-`: `my-append`.

Уловия `(if e1 e2 e3)`:

```scheme
; Пример рекурсивной функции с условием:
(define (pow x y)
  (if (= y 0) 1
      (* x (pow1 x (- y 1)))))
(pow1 2 3) ; 8
```

Каррирование в Ракет не очень часто используется, потому что можно передавать произвольное кол-во аргументов, но можно его юазть, если надо:

```scheme
(define pow2
  (lambda (x)
    (lambda (y)
      (pow1 x y))))
(define three-to-the (pow2 3))
(three-to-the 2)
```

## Racket Lists
[`null`](https://docs.racket-lang.org/reference/pairs.html#%28def._%28%28quote._~23~25kernel%29._null%29%29) — пустой список, функция `null?` проверяет, не пустой ли список:

```scheme
(define my-list null) ; `null` is bound to the empty list.
(null? my-list) ; #t
```

`(list e1 e2 ... en)` — список из n элементов. Синтаксический сахар для конструктора списков `(cons ...)`:

```scheme
(define my-list1 (list 1 2 3)) ; это то же самое, что
(define my-list2
    (cons 1 (cons 2 (cons 3 null))))
(equal? my-list1 my-list2) ; #t
```

`car/cdr` — голова/хвост списка:

```scheme
(car my-list1) ; 1
(cdr my-list1) ; '(2 3)
```

## Примеры
Функция, суммирующая элементы списка:

```scheme
(define (sum numbers)
  (if (null? numbers) 0
      (+ (car numbers) (sum (cdr numbers)))))

(sum (list 1 2 3 4)) ; 10
```

Функция `my-append`, которая добавляет один список в конец другого:

```scheme
(define (my-append2 xs ys)
  (if (null? xs) ys
      (cons (car xs) (my-append2 (cdr xs) ys))))
```

Функция `my-map`, которая пройдется по всем элементам списка и к каждому применит переданную функцию:

```scheme
(define (my-map xs fn)
  (if (null? xs) xs
      (cons (fn (car xs)) (my-map (cdr xs) fn))))
```

