(* Coursera Programming Languages, Homework 3, Provided Code *)

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

(**** you can put all your code here ****)

(* 1 *)
val only_capitals =
	List.filter (fn lst_item => Char.isUpper(String.sub(lst_item, 0)))

val test1 = only_capitals ["a","B","C"] = ["B","C"]

(* 2 *)
val longest_string1 =
	List.foldl (fn (str1, str2) =>
		if String.size(str1) > String.size(str2) then str1 else str2) "";

(* Сравнение начинается с пустой строки *)
val test21 = longest_string1 ["A","bc","cc", "C"] = "bc"
val test22 = longest_string1 ["bb","bc","C"] = "bb"
val test23 = longest_string1 [] = ""

(* 3 *)
val longest_string2 =
	List.foldl (fn (str1, str2) =>
		if String.size(str1) >= String.size(str2) then str1 else str2) "";

val test31 = longest_string2 ["AA","bc","C", "gg"] = "gg"
val test32 = longest_string2 ["S", "B", "C"] = "C"

(* 4.1 *)
fun longest_string_helper filter =
	List.foldl (fn (str1, str2) =>
				if filter(String.size(str1), String.size(str2))
				then str1
				else str2
			) "";

(* 4.2 *)
val longest_string3 = longest_string_helper(fn (a, b) => a > b);

val test42 = longest_string3 ["A","bc","C"] = "bc";

(* 4.3 *)
val longest_string4 = longest_string_helper(fn (a, b) => a >= b);

val test43 = longest_string4 ["A","B","C"] = "C";


(* 5 *)
val longest_capitalized = longest_string3 o only_capitals

val test5 = longest_capitalized ["bc","Cdzflksdjf", "Zdzflksdjf", "asdkfjad", "AAAAA"] = "Cdzflksdjf"

(* 6 *)
val rev_string = String.implode o List.rev o String.explode;
val test6 = rev_string "abc" = "cba"

(* 7 *)
fun first_answer f xs =
	case xs of
		[] => raise NoAnswer
		| x::xs' => case f(x) of
					NONE => first_answer f xs'
				  | SOME v => v;

val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4

(* 8 *)
fun all_answers f lst =
	let fun aux(xs, acc) =
		case xs of
			[] => SOME acc
		  | x::xs'  => case f(x) of
							NONE => NONE
						  | SOME v => aux(xs', acc @ v)
	in
		aux(lst, [])
	end

val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE

(* 9.1 *)
val count_wildcards = g (fn () => 1) (fn str => 0)
val test9a = count_wildcards Wildcard = 1

(* 9.2 *)
val count_wild_and_variable_lengths = g (fn () => 1) String.size
val test9b = count_wild_and_variable_lengths (Variable("a")) = 1

(* 9.3 *)
fun count_some_var (str, ptn) =
    g (fn () => 0) (fn s => if s = str then 1 else 0) ptn
val test9c = count_some_var ("x", Variable("x")) = 1

(* 10 *)
fun check_pat pat =
    let fun all_vars ptn =
            case ptn of
                Variable x => [x]
              | TupleP ps => List.foldl (fn (p, i) => i @ (all_vars p)) [] ps
              | ConstructorP(_, p) => all_vars p
              | _ => []
        fun is_uniq lst =
            case lst of
                [] => true
              | head::tail => (not (List.exists (fn str => str = head) tail))
                              andalso (is_uniq tail)
    in
        is_uniq(all_vars pat)
    end
val test10 = check_pat (Variable("x")) = true

(* 11 *)
fun match (va, pat) =
    case (va, pat) of
        (_, Wildcard) => SOME []
      | (v, Variable s) => SOME [(s, v)]
      | (Unit, UnitP) => SOME []
      | (Const i, ConstP j) => if i = j then SOME [] else NONE
      | (Tuple vs, TupleP ps) => if List.length vs = List.length ps
                                 then all_answers match (ListPair.zip(vs, ps))
                                 else NONE
      | (Constructor(s2, v), ConstructorP(s1, p)) => if s1 = s2
                                                     then match(v, p)
                                                     else NONE
      | (_, _) => NONE
val test11 = match (Const(1), UnitP) = NONE

(* 12 *)
fun first_match va plst =
    SOME (first_answer (fn x => match(va, x)) plst) handle NoAnswer => NONE
val test12 = first_match Unit [UnitP] = SOME []
