(* Calculate factorial with pattern matching *)
fun fact 0 = 1
  | fact n = n * fact(n - 1);

val x = fact 5;
