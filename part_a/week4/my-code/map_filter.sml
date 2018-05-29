fun map(f, xs) =
    case xs of
        [] => []
        | x::xs' => f(x)::map(f, xs');

val y1 = map(fn n => 1 + n, [1, 2, 3]);
val y2 = map(hd, [[1, 2, 3], [7, 9, 10]]);

fun filter(f, xs) =
    case xs of
        [] => []
        | x::xs' => if (f x)
                    then x::filter(f, xs')
                    else filter(f, xs');

val y3 = filter(fn n => n > 0, [~1, 2, 3, 4]);

fun is_even v = ((v mod 2) = 0);

fun all_even xs = filter(is_even, xs);
val y4 = all_even([2, 3, 4, 5, 6]);

fun all_even_2nd xs = filter((fn (_, v) => is_even v), xs);
val y5 = all_even_2nd([(2, 3), (0, 2), (3, 10), (5, 5)]);