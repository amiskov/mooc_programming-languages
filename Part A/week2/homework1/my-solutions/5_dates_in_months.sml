(*
5.
Write a function `dates_in_months` that takes a list of dates and a list of months (i.e., an int list)
and returns a list holding the dates from the argument list of dates that are in any of the months
in the list of months.

Assume the list of months has no number repeated.
Hint: Use your answer to the previous problem and SML’s list-append operator (@).
*)

(*use "4_dates_in_month.sml";*)

fun dates_in_months(dates : (int*int*int) list, months: int list) =
    if null months
    then []
    else dates_in_month(dates, hd(months))@dates_in_months(dates, tl(months))

(*val test1 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]*)
(*val test1 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) *)
