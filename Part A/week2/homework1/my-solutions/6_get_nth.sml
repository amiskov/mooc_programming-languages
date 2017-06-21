(* 6.
Write a function `get_nth` that takes a list of strings and an int `n` and returns the
nth element of the list where the head of the list is 1st. Do not worry about the case where
the list has too few elements: your function may apply hd or tl to the empty list in this case,
which is okay.
*)

fun get_nth(strs : string list, n : int) =
    if n = 1
    then hd(strs)
    else get_nth(tl(strs), n - 1)

(*val test1 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"
val test2 = get_nth (["ololo", "test", "gsom", "vasya"], 1)
*)    