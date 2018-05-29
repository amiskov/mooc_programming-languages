(* Variable bindings *)
val x = 34;
(* static environment: x : int *)
(* dynamic environment: x --> 34 *)

val y = 17;
(* static environment: x : int, y : int *)
(* dynamic environment: x --> 34, y --> 17 *)

(* Можно использовать только уже объявленные переменные *)
val z = (x + y) + (y + 2);
(* static environment: x : int, y : int, z : int (т. к. в выражении все int) *)
(* dynamic environment: x --> 34, y --> 17, z : 70 *)

val abs_of_z = if z < 0 then 0 - z else z;
(* static environment: `z < 0` --> bool, остальное : int.
   Оба варианта `then`/`else` должны иметь одинаковый тип. В данном случае : int.
*)
(* dynamic environment: x --> 34, y --> 17, z : 70 *)

val abs_of_z_simpler = abs z; (* уже есть такая ф-я. Можно писать `abs(z)` *)
