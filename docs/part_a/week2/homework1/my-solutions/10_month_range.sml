(*
10.
Write a function `month_range` that takes two days of the year `day1` and `day2` and returns
an `int list [m1, m2, ..., mn]` where `m1` is the month of `day1`, `m2` is the month of `day1+1, ...`,
and `mn` is the month of day `day2`.

Note the result will have length `day2 - day1 + 1` or `length 0 if day1>day2`.
*)

(*use "9_what_month.sml";*)

fun month_range(day1 : int, day2 : int) = (* -> int list *)
    if day1 > day2
    then []
    else what_month(day1)::month_range(day1 + 1, day2)

(*val test10 = month_range (31, 34) = [1,2,2,2]*)
