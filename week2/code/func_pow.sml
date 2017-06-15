(* y must be >= 0 *)
fun pow(x : int, y : int) = 
    if y = 0
    then 1
    else x * pow(x, y-1)

fun cube(x : int) =
    pow(x, 3)

val twenty_seven = pow(3, 3)
val sixty_four = cube(4)