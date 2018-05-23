(*
Write a function `number_in_months` that takes a list of dates and a list of months
(i.e., an int list) and returns the number of dates in the list of dates that are
in any of the months in the list of months.

Assume the list of months has no number repeated.
Hint: Use your answer to the previous problem.
*)

(*use "2_number_in_month.sml";*)

fun number_in_months(dates :(int*int*int) list, months :int list) = (* -> int *)
    if null months
    then 0
    else number_in_month(dates, hd(months)) + number_in_months(dates, tl(months))

(*val test3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3*)
