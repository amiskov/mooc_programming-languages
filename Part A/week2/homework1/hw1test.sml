(* Homework1 Simple Test
These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader
To run the test, add a new line to the top of this file: use "homeworkname.sml";
All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

(*use "my-solutions/1_is_older.sml";
use "my-solutions/2_number_in_month.sml";
use "my-solutions/3_number_in_months.sml";
use "my-solutions/4_dates_in_month.sml";
use "my-solutions/5_dates_in_months.sml";
use "my-solutions/6_get_nth.sml";
use "my-solutions/7_date_to_string.sml";
use "my-solutions/8_number_before_reaching_sum.sml";
use "my-solutions/9_what_month.sml";
use "my-solutions/10_month_range.sml";
use "my-solutions/11_oldest.sml";
*)

use "my-solutions/for_submit.sml";

val test1 = is_older ((1,2,3),(2,3,4)) = true
val test2 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1
val test3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3
val test4 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
val test6 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"
val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"
val test8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3
val test9 = what_month 70 = 3
val test10 = month_range (31, 34) = [1,2,2,2]
val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31) 
