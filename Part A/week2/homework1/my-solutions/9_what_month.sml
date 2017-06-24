(*
9.
Write a function `what_month` that takes a day of year (i.e., an int between 1 and 365)
and returns what month that day is in (1 for January, 2 for February, etc.).
Use a list holding 12 integers and your answer to the previous problem.
*)

(*use "8_number_before_reaching_sum.sml";*)

val month_durations = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

fun what_month(day : int) =
    number_before_reaching_sum(day, month_durations) + 1

(*val test9 = what_month 70 = 3*)
