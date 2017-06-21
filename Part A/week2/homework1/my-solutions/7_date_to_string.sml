(* 7.
Write a function `date_to_string` that takes a date and returns a string of the form
January 20, 2013 (for example).

Use the operator `^` for concatenating strings and the library function `Int.toString`
for converting an `int` to a `string`.

For producing the month part, do not use a bunch of conditionals. Instead, use a list holding
12 strings and your answer to the previous problem. For consistency, put a comma following
the day and use capitalized English month names: January, February, March, April, May, June,
July, August, September, October, November, December.
*)

(*use "6_get_nth.sml";*)
val month_names = ["January", "February", "March", "April", "May", "June", "July",
              "August", "September", "October", "November", "December"];

fun date_to_string(year:int, month:int, day:int) =
    get_nth(month_names, month) ^ " " ^ Int.toString(day) ^ ", " ^ Int.toString(year)

(*val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"*)
