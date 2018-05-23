fun n_times (f,n,x) = 
    if n=0
    then x
    else f (n_times(f,n-1,x))

fun increment x = x+1


fun decrement x = x-1

(* Не полиморфная, высшего порядка *)
(* Считает число вызовов `f` пока не будет возвращен `0` *)
fun times_until_zero (f,x) = 
    if x=0 then 0 else 1 + times_until_zero(f, f x)

val x = times_until_zero(decrement, 3)

(* Полиморфная, не высшего порядка *)
(* Считает число элементов в списке, список может содержать данные любого типа *)
fun len xs =
    case xs of
       [] => 0
      | _::xs' => 1 + len xs'

val test_len1 = len([1, 2, 3, 4])
val test_len2 = len(["a", "b", "c"])
