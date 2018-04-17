exception NoAnswer

datatype pattern = Wildcard
         | Variable of string
         | UnitP
         | ConstP of int
         | TupleP of pattern list
         | ConstructorP of string * pattern

datatype valu = Const of int
          | Unit
          | Tuple of valu list
          | Constructor of string * valu

fun g f1 f2 p =
    let 
    val r = g f1 f2 
    in
    case p of
        Wildcard          => f1 ()
      | Variable x        => f2 x
      | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
      | ConstructorP(_,p) => r p
      | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
         | UnitT
         | IntT
         | TupleT of typ list
         | Datatype of string

(* 1 *)
val only_capitals = List.filter (fn s => Char.isUpper(String.sub(s, 0)))

(* 2 *)
val longest_string1 = List.foldl (fn (s, acc) => 
  if String.size s > String.size acc then s else acc) ""

(* 3 *)
val longest_string2 = List.foldl (fn (s, acc) => 
  if String.size s >= String.size acc then s else acc) ""

(* 4 *)
fun longest_string_helper cmp = List.foldl (fn (s, acc) => 
  if cmp(String.size s, String.size acc) then s else acc) ""

val longest_string3 = longest_string_helper (fn (l1, l2) => l1 > l2)
val longest_string4 = longest_string_helper (fn (l1, l2) => l1 >= l2)

(* 5 *)
val longest_capitalized = List.foldl (fn (s, acc) => 
  if String.size s > String.size acc andalso 
    (Char.isUpper o String.sub) (s, 0) then s else acc) ""

(* 6 *)
val rev_string = String.implode o List.rev o String.explode

(* 7 *)
fun first_answer check xs = 
  case xs of
       [] => raise NoAnswer
     | x::xs' => case check x of
                     SOME v => v
                   | NONE => first_answer check xs'

(* 8 *)
fun all_answers check xs = 
  let fun aux (xs, acc) =
      case xs of
           [] => SOME acc
         | x::xs' => case check x of
                          NONE => NONE
                        | SOME lst => aux(xs', lst @ acc)
  in
    aux(xs, [])
  end

(* 9.a *)
val count_wildcards = g (fn _ => 1) (fn _ => 0)

(* 9.b *)
val count_wild_and_variable_lengths = g (fn _ => 1) String.size

(* 9.c *)
fun count_some_var (s, p) = g (fn _ => 0) (fn v => if v = s then 1 else 0) p

(* 10 *)
val check_pat = 
  let
    fun varnames p =
        case p of
            Variable x        => [x]
          | TupleP ps         => List.foldl (fn (p,i) => (varnames p) @ i) [] ps
          | ConstructorP(_,p) => varnames p
          | _                 => []

    fun no_repeats xs = 
      case xs of
           [] => true
         | x::xs' => not (List.exists (fn y => x = y) xs') andalso no_repeats xs' 
  in
    no_repeats o varnames
  end

(* 11 *)
fun match m = 
  case m of
       (_, Wildcard) => SOME []
     | (v, Variable s) => SOME [(s, v)]
     | (Unit, UnitP) => SOME []
     | (Const c, ConstP p) => if c = p then SOME[] else NONE
     | (Tuple vs, TupleP ps) => all_answers match (ListPair.zip(vs, ps))
     | (Constructor (s2, v), ConstructorP (s1, p)) => 
         if s1 = s2 then match (v, p) else NONE
     | _ => NONE

(* 12 *)
fun first_match v ps = 
  SOME (first_answer (fn p => match(v, p)) ps) 
  handle NoAnswer => NONE