fun list_product(xs : int list) =
    if null xs
    then 1 (* не 0, потому что в конце идет умножение, а не сложение *)
    else hd xs * list_product(tl xs)

val product = list_product([2, 3, 4])