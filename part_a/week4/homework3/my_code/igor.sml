(* Igor G. Peternella - assignment 3 *)

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
              
(* ex 1: Write a function only_capitals that takes a string list and returns a 
   string list that has only the strings in the argument that start with an 
   uppercase letter. Assume all strings have at least 1 character. Use List.filter, 
   Char.isUpper, and String.sub to make a 1-2 line solution.*)
        
fun only_capitals str_lst =
  List.filter (fn str => (Char.isUpper o String.sub) (str, 0)) str_lst
               
  
(* ex 2: Write a function longest_string1 that takes a string list and returns the longest 
   string in the list. If the list is empty, return "". In the case of a tie, return 
   the string closest to the beginning of the list. Use foldl, String.size, and no recursion 
   (other than the implementation of foldl is recursive). *)

fun longest_string1 str_lst =
  case str_lst of
      []      => ""
    | s :: _ => List.foldl (fn (hd, acc) => if String.size acc >= String.size hd
                                            then acc   
                                            else hd) s str_lst
                           
(* ex 3: Write a function longest_string2 that is exactly like longest_string1 except in 
   the case of ties it returns the string closest to the end of the list. Your solution should
   be almost an exact copy of longest_string1. Still use foldl and String.size. *)
                           
fun longest_string2 str_lst =
  case str_lst of
      []      => ""
    | s :: _ => List.foldl (fn (hd, acc) => if String.size acc > String.size hd
                                            then acc   
                                            else hd) s str_lst

(* ex 4: Write functions longest_string_helper, longest_string3, and longest_string4 such that:
   1. longest_string3 has the same behavior as longest_string1 and longest_string4 has the
      same behavior as longest_string2.
   2. longest_string_helper has type (int * int -> bool) -> string list -> string
      (notice the currying). This function will look a lot like longest_string1 and longest_string2
      but is more general because it takes a function as an argument.
   3. If longest_string_helper is passed a function that behaves like > (so it returns true exactly
      when its first argument is stricly greater than its second), then the function returned has the same
      behavior as longest_string1.
   4. longest_string3 and longest_string4 are defined with val-bindings and partial applications
      of longest_string_helper. *)

fun longest_string_helper f str_lst =
  case str_lst of
      [] => ""
    | hd :: tl => let val prev = longest_string_helper f tl
                  in
                      if f(String.size prev, String.size hd)
                      then prev
                      else hd
                  end
                      
val longest_string3 = longest_string_helper (fn (x,y) => x > y) (* partial app *)
val longest_string4 = longest_string_helper (fn (x,y) => x >= y) (* partial app *)

(*
        fun fold (f, acc, xs) =
  case xs of
      [] => acc
    | x :: xs' => fold(f, f(x, acc), xs') 
*)
                                            
(* ex 5: Write a function longest_capitalized that takes a string list and returns the 
   longest string in the list that begins with an uppercase letter, or "" if there are no 
   such strings. Assume all strings have at least 1 character. Use a val-binding and the 
   ML library's o operator for composing functions. Resolve ties like in problem 2. *)

fun longest_capitalized str_lst =
  let
      val uppercased_lst = List.filter (fn str => (Char.isUpper o String.sub) (str, 0)) str_lst 
  in
      case uppercased_lst of
          [] => ""
        | _  => longest_string1 uppercased_lst 
  end

(* ex 6: Write a function rev_string that takes a string and returns the string that is 
   the same characters in reverse order. Use ML's o operator, the library function rev for 
   reversing lists, and two library functions in the String module. (Browse the module 
   documentation to find the most useful functions.) *)

fun rev_string s =
  (String.implode o List.rev o String.explode) s 

(* ex 7: Write a function first_answer of type ('a -> 'b option) -> 'a list -> 'b (notice
   the 2 arguments are curried). The first argument should be applied to elements of the 
   second argument in order until the first time it returns SOME v for some v and then v 
   is the result of the call to first_answer. If the first argument returns NONE for all 
   list elements, then first_answer should raise the exception NoAnswer. *)

fun first_answer f xs =
  let fun aux opt_lst =
        case opt_lst of
            []             => raise NoAnswer (* if empty list is reached then everything was NONE *)
         |  NONE :: tl     => aux tl         (* continue until first SOME v is found *)
         | (SOME v) :: res => v              (* returns the first value *)
  in aux (List.map f xs) end (* applies f to the whole list to get an options list argument for aux fn *)

(* ex 8: Write a function all_answers of type ('a -> 'b list option) -> 'a list -> 'b list option
   (notice the 2 arguments are curried). The first argument should be applied to elements of the second
   argument. If it returns NONE for any element, then the result for all_answers is NONE. Else the
   calls to the first argument will have produced SOME lst1, SOME lst2, ... SOME lstn and the result of
   all_answers is SOME lst where lst is lst1, lst2, ..., lstn appended together (order doesn't matter).
   Hints: The sample solution is 8 lines. It uses a helper function with an accumulator and uses @. Note
   all_answers f [] should evaluate to SOME []. *)
  
fun all_answers f xs =
  let val options_lst = List.map f xs (* [SOME[1], SOME[2], NONE, SOME[3], ...] *)
      fun aux ops =
        case ops of        
             []                 => SOME []
           | (NONE) :: _        => NONE
           | (SOME lst) :: rest => case (aux rest) of NONE => NONE | SOME thing => SOME (lst @ thing)
  in (aux options_lst) end

(* ex 9:  A function g has been provided to you.
   (a) Use g to define a function count_wildcards that takes a pattern and returns how many Wildcard
   patterns it contains.

   (b) Use g to define a function count_wild_and_variable_lengths that takes a pattern and returns
   the number of Wildcard patterns it contains plus the sum of the string lengths of all the variables
   in the variable patterns it contains. (Use String.size. We care only about variable names; the
   constructor names are not relevant.)

   (c) Use g to define a function count_some_var that takes a string and a pattern (as a pair) and
   returns the number of times the string appears as a variable in the pattern. We care only about
   variable names; the constructor names are not relevant. *)

fun count_wildcards p =
  g (fn () => 1) (fn str => 0) p

fun count_wild_and_variable_lengths p =
  g (fn () => 1) (fn str => (String.size str)) p

fun count_some_var (s, p) =
  g (fn () => 0) (fn str => if str = s then 1 else 0) p
    
(* ex 10: Write a function check_pat that takes a pattern and returns true if and only if all the variables
   appearing in the pattern are distinct from each other (i.e., use different strings). The constructor
   names are not relevant. Hints: The sample solution uses two helper functions. The first takes a
   pattern and returns a list of all the strings it uses for variables. Using foldl with a function that uses
   @ is useful in one case. The second takes a list of strings and decides if it has repeats. List.exists may
   be useful. Sample solution is 15 lines. These are hints: We are not requiring foldl and List.exists
   here, but they make it easier. *)

fun check_pat p =
  let fun extract_strings p =
        case p of
            Variable x => [x]
          | TupleP ps => List.foldl (fn (ptrn, acc) => case ptrn of
                                                           Variable x => x :: acc
                                                         | ConstructorP(_, ptrn) => (extract_strings ptrn) @ acc
                                                         | TupleP _ => (extract_strings ptrn) @ acc
                                                         | _ => acc) [] ps
          | ConstructorP(_, ptrn) => extract_strings ptrn
          | _ => []
                     
      fun has_repeated xs =
        case xs of
            []       => true
          | x :: xs' => let val prev = has_repeated xs' (* (!) Runs in quadratic time (!) *)
                        in prev andalso not (List.exists(fn y => y = x) xs') end
                            
  in (has_repeated o extract_strings) p end

(* ex 11: Write a function match that takes a valu * pattern and returns a (string * valu) list option,
   namely NONE if the pattern does not match and SOME lst where lst is the list of bindings if it does.
   Note that if the value matches but the pattern has no patterns of the form Variable s, then the result
   is SOME []. Hints: Sample solution has one case expression with 7 branches. The branch for tuples
   uses all_answers and ListPair.zip. Sample solution is 13 lines. Remember to look above for the
   rules for what patterns match what values, and what bindings they produce. These are hints: We are
   not requiring all_answers and ListPair.zip here, but they make it easier. *)

fun match (v, p) =
  case (v, p) of
      (_, Wildcard)         => SOME []
    | (_, Variable x)       => SOME [(x, v)]
    | (Unit, UnitP)         => SOME []
    | (Const x, ConstP y)   => if x = y then SOME [] else NONE
    | (Tuple vs, TupleP ps) => if (List.length vs) <> (List.length ps) (* vs and ps must have same length *)
                               then NONE
                               else all_answers match (ListPair.zip(vs, ps)) (* Zipped list: (val * ptrn) list *)
    | (Constructor(s1, x), ConstructorP(s2, y)) => if s1 <> s2
                                                   then NONE
                                                   else match(x, y)
    | _ => NONE

(* ex 12: Write a function first_match that takes a value and a list of patterns and returns a
   (string * valu) list option, namely NONE if no pattern in the list matches or SOME lst where
   lst is the list of bindings for the first pattern in the list that matches. Use first_answer and a
   handle-expression. Hints: Sample solution is 3 lines. *)

fun first_match v ps =
  SOME (first_answer (fn p => match(v, p)) ps) (* first_answer does not return an option so we use SOME *)
  handle NoAnswer => NONE