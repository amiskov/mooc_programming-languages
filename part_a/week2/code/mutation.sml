val x = [1, 2, 3];
val y = x;
x = y; (* true *)

val y = 4::y;
x = y; (* false *)