datatype mytype = 
    TwoInts of int * int 
    | Str of string
    | Pizza; (* не конструктор, а уже значение типа mytype *)

val x = TwoInts(2, 3); (* возвращает тип mytype *)
val y = Str("hello");
val z = Pizza;

x;

datatype printer_status =
    Printing
    | Waiting
    | Error;