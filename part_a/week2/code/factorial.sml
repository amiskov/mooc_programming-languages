use "countdown.sml";
use "list_product.sml";

fun factorial (n : int) =
    list_product(countdown n)

val fac7 = factorial 7;