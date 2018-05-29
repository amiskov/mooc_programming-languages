fun increment x = x + 1;

fun n_times (f, n, x) =
    if n = 0
    then x
    else f(n_times(f, n-1, x));

val x = n_times(increment, 3, 10)