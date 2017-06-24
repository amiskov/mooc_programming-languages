(* 8.
Write a function `number_before_reaching_sum` that takes an `int` called `sum`, which you can assume
is positive, and an `int list`, which you can assume contains all positive numbers, and returns an `int`.
    
You should return an `int n` such that the first `n` elements of the list add to less than `sum`,
but the first `n + 1` elements of the list add to `sum` or more.

Assume the entire list sums to more than the passed in value;
it is okay for an exception to occur if this is not the case.
*)

fun number_before_reaching_sum(sum : int, lst : int list) = (* -> int *)
    if null lst 
    then 0
    else
        let
            fun acc(counter : int, sum_inner : int, lst_inner : int list) =
                if (sum_inner + hd(lst_inner)) >= sum
                then counter
                else acc(counter + 1, sum_inner + hd(lst_inner), tl(lst_inner))
        in
            acc(0, 0, lst)
        end 

(*
В этой задаче поможет расписать итерации внутренней рекурсии (acc):
1, 1, [2, 3, 4, 5]
2, 3, [3, 4, 5]
3, 9, [4, 5]
*)

(*val test8 = number_before_reaching_sum (10, [1,2,3,4,5])*)
(*val test8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3*)
(*val test8_1 = number_before_reaching_sum (20, [1,2,3,4,5,6, 7, 8,9,10,11]) = 5*)
