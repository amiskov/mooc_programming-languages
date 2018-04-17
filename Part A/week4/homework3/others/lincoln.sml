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
      | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps (*if pattern tuple, recursively call g on each and return the total sum*)
      | ConstructorP(_,p) => r p (*if pattern constructor*)
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
fun only_capitals(words: string list) =
    let
        fun firstIsUpper text= Char.isUpper(String.sub(text, 0))
    in
        List.filter firstIsUpper words
    end

(*2*)
fun longest_string1(words: string list) =
    foldl (fn (current,acc) => if (String.size current > String.size acc) then current else acc) "" words

(* 3 *)
fun longest_string2(words: string list) =
    foldl (fn (current,acc) => if (String.size current >= String.size acc) then current else acc) "" words

(* 4 *)
fun longest_string_helper predicate (words: string list) =
    foldl (fn (current, acc) =>
      if predicate(String.size current, String.size acc)
      then current
      else acc) "" words

(* 5* *)
val longest_string3= longest_string_helper (fn (a,b)=> a>b)

(* 6* *)
val longest_string4= longest_string_helper (fn (a,b)=> a>=b)


(* 5 , 7* *)
val longest_capitalized= longest_string3 o only_capitals

(* 6, 8* *)
val rev_string= String.implode o List.rev o String.explode

(* 7, 9* *)
fun first_answer function [] = raise NoAnswer
    |first_answer function (first::data) =
        case function first of
            SOME result => result
            | NONE => first_answer function data

(* 8 10* *)
fun all_answers function data =
    let
        fun all_answers2(acc, []) = SOME acc
            |all_answers2(acc, first::data) =
            case function first of
                SOME result => all_answers2(acc@result, data)
                | NONE => NONE
    in
        all_answers2([], data)
    end

(* 9, 11* *)
val count_wildcards = g (fn _ => 1) (fn _ => 0)

(* 10, 12* *)
val count_wild_and_variable_lengths = g (fn _ => 1) (fn variable => String.size variable)

fun count_some_var(var, patt) =
    g (fn _ => 0) (fn variable => if variable=var then 1 else 0) patt

val check_pat =
    let
        fun dup_exists [] = false
            |dup_exists (first::words) =
                List.exists (fn var:string=> var=first) words orelse dup_exists(words)
        fun get_variables p =
            case p of
                Variable x        => [x]
              | TupleP ps         => List.foldl (fn (p,acc) => acc@get_variables p) [] ps
              | ConstructorP(_,p) => get_variables p (*if pattern constructor*)
              | _                 => []
    in
        not o dup_exists o get_variables
    end

fun match(query) =
    case query of
        (_, Wildcard) => SOME([])
        | (value, Variable s) => SOME([(s, value)])
        | (Unit, UnitP) => SOME([])
        | (Const value, ConstP s) => if value=s then SOME([]) else NONE
        | (Tuple vs, TupleP ps) => if List.length vs = List.length ps then all_answers match (ListPair.zip(vs, ps)) else NONE
        | (Constructor(nameV, valueV), ConstructorP(nameP, valueP)) => if nameP=nameV then match(valueV, valueP) else NONE
        | _ => NONE

fun first_match value ps =
    SOME (first_answer (fn patt => match(value, patt)) ps)
    handle NoAnswer => NONE