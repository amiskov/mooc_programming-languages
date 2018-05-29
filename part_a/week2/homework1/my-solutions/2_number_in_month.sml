(* 2. =================
Write a function `number_in_month` that takes a list of dates and a month (i.e., an int)
and returns how many dates in the list are in the given month.
*)
fun number_in_month (dates : (int * int * int) list, month : int) =
    if null dates
    then 0
    else if (#2 (hd(dates))) = month
            then 1 + number_in_month(tl(dates), month)
            else number_in_month(tl(dates), month) (* если месяц не подходит, то проверяем дальше *)

(*val test1 = number_in_month ([(2012,0,28),(2013,2,1)],2) = 1
val test2 = number_in_month ([(2012,3,28),(2013,12,1)],2) = 0
val test3 = number_in_month ([(2000,3,3), (3,3,3),   (2, 0, 4)], 3) = 2
val test4 = number_in_month ([(2012,2,28),(2013,2,1),(2011,3,31),(2011,5,28)], 5) = 1
val test5 = number_in_month ([],3) = 0
*)
