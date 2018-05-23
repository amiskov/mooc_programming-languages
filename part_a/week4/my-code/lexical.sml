(* ML *)
val x = 1
fun f(y) = x + y (* замкнули `x = 1`
                    в лексическом окружении *)
val x = 2
val y = 3

val z = f (x + y) (* => 6 *)

