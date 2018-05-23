(*
4.
Write a function `dates_in_month` that takes a list of dates and a month (i.e., an int)
and returns a list holding the dates from the argument list of dates that are in the month.
The returned list should contain dates in the order they were originally given.
*)

fun dates_in_month(dates : (int * int * int) list, month : int) = (* -> list *)
    if null dates
    then []
    else if (#2 (hd(dates))) = month
            then hd(dates)::dates_in_month(tl(dates), month)
            else dates_in_month(tl(dates), month)

(*val test1 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]*)
(*val test2 = dates_in_month ([(2012,10,28),(2013,2,1),(2012,2,28)],2) = [(2013,2,1),(2012,2,28)]*)
