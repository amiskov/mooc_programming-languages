(*
11.
Write a function `oldest` that takes a list of dates and evaluates to an `(int*int*int)` option.
It evaluates to `NONE` if the list has no dates and `SOME d` if the date `d` is the oldest date
in the list.
*)

use "1_is_older.sml";

fun oldest(dates : (int * int * int) list) =
    if null dates
    then NONE
    else
        let
            fun compare_dates(date : int * int * int, dates : (int * int * int) list) =
                if null dates
                then date
                else
                    if is_older(date, hd(dates))
                    then compare_dates(date, tl(dates))
                    else compare_dates(hd(dates), tl(dates))
        in
            SOME (compare_dates(hd(dates), tl(dates)))
        end

val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31) 
val test11_1 = oldest([(5,5,2),(5,10,2),(5,2,2),(5,12,2)]) = SOME (5,2,2)
