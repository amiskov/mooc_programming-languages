(* 1. =================
Write a function `is_older` that takes two dates and evaluates to `true` or `false`.
It evaluates to `true` if the first argument is a date that comes before the second argument.
(If the two dates are the same, the result is `false`.)
*)
fun is_older(date1 : int * int * int, date2 : int * int * int) =
    let
        fun equal(a : int, b : int) = a = b
        fun less(a : int, b : int) = a < b
    in
        less(#1 date1, #1 date2)
        orelse
            (equal(#1 date1, #1 date2) andalso less(#2 date1, #2 date2))
        orelse
            (equal(#1 date1, #1 date2)
                andalso equal(#2 date1, #2 date2)
                andalso less(#3 date1, #3 date2))
    end

(* true *)
(*val test1 = is_older((2017, 11, 2), (2017, 11, 3));
val test2 = is_older((2015, 11, 2), (2017, 11, 2));
*)
(* false *)
(*val test3 = is_older((4, 3, 2), (2, 3, 4));
val test4 = is_older((4, 3, 2), (4, 3, 2));
*)