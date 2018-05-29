fun compose (f, g) = fn x => f(g x);
(* Тип: ('b -> c') * ('a -> 'b) -> ('a -> 'c) *)

fun f1 x = x * x;
fun g1 x = x div 2;

val cf = f1 o g1; (* Композиция, оператор `o` *)

val t = cf 10;

(* Получить корень абсолютного значения числа *)
fun sqrt_of_abs_old i = Math.sqrt(Real.fromInt(abs i)); (* Как обычно *)
fun sqrt_of_abs_ i = (Math.sqrt o Real.fromInt o abs) i; (* Через композицию *)

val sqrt_of_abs = Math.sqrt o Real.fromInt o abs; (* без лишнего *)
val test = sqrt_of_abs(10);


(* Слева-направо *)
infix !> (* Объявляем инфиксную функцию (между операндами) *)
(* Типа как `|>` в F#. В ML `|` зарезервировано, так что используем `!` *)
fun x !> f = f x; (* Передаем x в функцию и вызываем ее *)

fun sqrt_of_abs_infix i = i !> abs !> Real.fromInt !> Math.sqrt;
val test3 = sqrt_of_abs_infix 10;
