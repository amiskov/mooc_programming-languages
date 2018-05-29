fun sum_pair_list (xs : (int * int) list) = (* xs — список из пар *)
    if null xs
    then 0
    else #1 (hd xs) + #2 (hd xs) + sum_pair_list(tl xs)
val sum = sum_pair_list([(1, 2), (2, 3), (3, 4)]);

fun firsts (xs : (int * int) list) = (* оставить только первые элементы в парах *)
    if null xs
    then []
    else (#1 (hd xs)) :: firsts(tl xs)
val f = firsts([(1, 2), (2, 3), (3, 4)]);

fun seconds (xs : (int * int) list) = (* оставить только первые элементы в парах *)
    if null xs
    then []
    else (#2 (hd xs)) :: seconds(tl xs)
val s = seconds([(1, 2), (2, 3), (3, 4)]);


use "sum_list.sml";
fun sum_pair_list2 (xs : (int * int) list) =
    sum_list(firsts xs) + sum_list(seconds xs)

val sum2 = sum_pair_list2([(1, 2), (2, 3), (3, 4)]);
