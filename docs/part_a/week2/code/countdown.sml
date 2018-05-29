fun countdown(x : int) =
    if x = 0
    then []
    else x :: countdown(x - 1)

val from_7 = countdown 7;