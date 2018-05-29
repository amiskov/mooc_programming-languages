fun inc_or_zero intoption =
    case intoption of
        NONE => 0
      | SOME i => i + 1;

fun sum_list xs =
    case xs of
        [] => 0
      | x::xs' => x + sum_list xs'; (* `;` обязательно *)

sum_list [1, 2, 3]; (* `;` обязательно *)

fun append (xs, ys) =
    case xs of
        [] => ys
      | x::xs' => x::append(xs', ys); (* `;` обязательно *)

append([1, 2, 3], [4, 5]);
