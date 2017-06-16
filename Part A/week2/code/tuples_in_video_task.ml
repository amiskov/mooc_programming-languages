val x = (3, (4, (5, 6))); (* (int, (int, (int, int))) *)

val y = (#2 x, (#1 x, #2 (#2 x)));

val ans = (#2 y, 4);


(*
x : ( int, (int, (int, int)) )
y : ( (int, (int, int)), (int, (int, int)) )
ans : ( (int, (int, int)), int ) 
*)(* правильно! *)
