fun sorted3_tupled (x, y, z) = z >= y andalso y >= x;
val t1 = sorted3_tupled(7, 8, 9);

(* Через каррирование *)
val sorted3 = fn x => fn y => fn z => z >= y andalso y >= x;
val t2 = ((sorted3 7) 8) 9;


fun sorted3_nicer x y z =
    z >= y andalso y >= x;

val t3 = sorted3 7 8 9;


fun sum a b c = a + b + c;
val t = sum 1 2 3;
