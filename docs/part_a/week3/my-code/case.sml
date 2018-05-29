datatype mytype = 
    TwoInts of int * int 
    | Str of string
    | Pizza;

fun f (x : mytype) = (* можно просто `fun x` *)
    case x of
        (* Дальше идет pattern matching:
        Проверить паттерн слева, если он подходит `x`, то создать локальные
        переменные и справа от стрелки что-то с ними сделать *)
        Pizza => 3
        | Str(s) => 8 (* можно просто `Str s` *)
        | TwoInts(i1, i2) => i1 + i2;

        (* У всех веток результат должен быть одного типа, как у `if/then/else` *)

        (* Слева от стрелки — паттерны, не выражения (patterns, not expressions),
        они не выполняются. Тут происходит создание переменных для последующих
        манипуляций с ними справа от стрелки *)

val a = f(Pizza);

val ti = TwoInts(10, 5);
val c = f(ti);

val b = f(Str "hello");
