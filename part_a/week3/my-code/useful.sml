(* Cards *)
datatype suit = Club | Diamond | Heart | Spade;
datatype rank = Jack | Queen | King | Ace | Num of int;

(* Теперь можно представить карту добавив each of тип, который будет использовать
`suit` и `rank` *)

(* People: 2 альтернативных способа идентификации студента *)
datatype id = StudentNum of int
            | Name of string
                      * (string option)
                      * string


(*
`id` — хороший подход к идентификации. Студенты в основном имеют свой номер,
а те кто не имеют, того можно вычислить по ФИО. Тут each of не подходит, потому что
надо либо номер, либо ФИО. Оба варианта будут избыточны. Это можно сделать в `case`:
если есть номер — то вернуть его, если его нету, то вернуть ФИО.
*)

(* Programming Languages, Dan Grossman *)
(* Section 2: Useful Datatypes *)

datatype exp = Constant of int 
             | Negate of exp 
             | Add of exp * exp
             | Multiply of exp * exp

fun eval e =
    case e of
        Constant i => i
      | Negate e2  => ~ (eval e2)
      | Add(e1,e2) => (eval e1) + (eval e2)
      | Multiply(e1,e2) => (eval e1) * (eval e2)

fun number_of_adds e =
    case e of
        Constant i      => 0
      | Negate e2       => number_of_adds e2
      | Add(e1,e2)      => 1 + number_of_adds e1 + number_of_adds e2
      | Multiply(e1,e2) => number_of_adds e1 + number_of_adds e2

val example_exp = Add (Constant 19, Negate (Constant 4))

val example_ans = eval example_exp

val example_addcount = number_of_adds (Multiply(example_exp,example_exp))
