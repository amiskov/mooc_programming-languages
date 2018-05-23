(* Each of pattern matching *)
(* Poor style examples just for understanding the concept:
нет смысла использовать `case`, потому что всего 1 ветка *)
fun sum_triple1 triple =
    case triple of
        (x, y, z) => x + y + z;

fun full_name1 r =
    case r of
        {first = x, middle = y, last = z} => x ^ " " ^ y ^ " " ^ z;

(* Ok style:
вместо `case` используется `val`, который тоже использует паттерн-матчинг: *)
fun sum_triple2 triple =
    let val (x, y, z) = triple;
    in
        x + y + z
    end

fun full_name2 r =
    let val {first=x,middle=y,last=z} = r
    in
        x ^ " " ^ y ^ " " ^z
    end

(* Good style *)
fun sum_triple3 (x, y, z) = x + y + z;
fun full_name3 {first=x, middle=y, last=z} = x ^ " " ^ y ^ " " ^z;

val x = sum_triple3(1, 2, 3);
val y = full_name3({first="Andrey", middle="Y.", last="Miskov"});
