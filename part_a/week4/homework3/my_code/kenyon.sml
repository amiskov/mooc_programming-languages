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

fun only_capitals sl =
  List.filter (fn s => (Char.isUpper o String.sub) (s, 0)) sl

fun longest_string1 sl =
  List.foldl (fn (s, acc) => if String.size(s) > String.size(acc) then s else acc) "" sl

fun longest_string2 sl =
  List.foldl (fn (s, acc) => if String.size(s) >= String.size(acc) then s else acc) "" sl

fun longest_string_helper f sl =
  List.foldl (fn (s, acc) => if f(String.size(s), String.size(acc)) then s else acc) "" sl

val longest_string3 = longest_string_helper (fn (x, y) => x > y)

val longest_string4 = longest_string_helper (fn (x, y) => x >= y)

val longest_capitalized = longest_string1 o only_capitals

val rev_string = String.implode o List.rev o String.explode

fun first_answer f l =
  case l of
      [] => raise NoAnswer
    | lh::lt => case f lh of
            SOME v => v
          | NONE => first_answer f lt

fun all_answers f l =
  let fun aux arg =
    case arg of
        ([], acc) => acc
      | (_, NONE) => NONE
      | (lh::lt, SOME lst) => case f lh of
                      SOME v => aux(lt, SOME(lst @ v))
                    | NONE => NONE
  in aux(l, SOME []) end

val count_wildcards = g (fn () => 1) (fn x => 0)

val count_wild_and_variable_lengths = g (fn () => 1) String.size

fun count_some_var (s, p) =
  g (fn () => 0) (fn x => if x = s then 1 else 0) p

fun check_pat p =
  let fun extract (p, acc) =
    case p of
        Variable x => x::acc
      | TupleP ps => List.foldl (fn (p, a) => extract(p, a)) acc ps
      | ConstructorP(_, p) => extract(p, acc)
      | _ => acc

      fun is_unique sl =
    case sl of
        [] => true
      | h::lt => not(List.exists (fn x:string => h = x) lt) andalso is_unique lt
  in
      is_unique(extract(p, []))
  end

fun match pair =
  case pair of
      (_, Wildcard) => SOME []
    | (v, Variable s) => SOME [(s, v)]
    | (Unit, UnitP) => SOME []
    | (Const i, ConstP j) => if i = j then SOME [] else NONE
    | (Tuple vs, TupleP ps) => if length vs = length ps
                   then all_answers match (ListPair.zip(vs, ps))
                   else NONE
    | (Constructor(s2, v), ConstructorP(s1, p)) => if s1 = s2
                           then match (v, p)
                           else NONE
    | _ => NONE

fun first_match v ps =
  SOME(first_answer (fn p => match (v, p)) ps) handle NoAnswer => NONE
                                      
fun typecheck_patterns (dts, ps) =
  let
      exception Conflict
      fun no_conflict (t1, t2) =
    case (t1, t2) of
        (_, Anything) => true
      | (Anything, _) => true
      | (TupleT tb, TupleT ta) => (List.length tb = List.length ta)
                      andalso
                      (List.all no_conflict o ListPair.zip) (tb, ta)
      | _ => t1 = t2
              
      fun what_type p =
    case p of
        Wildcard => Anything
      | Variable _ => Anything
      | UnitP => UnitT
      | ConstP _ => IntT
      | TupleP ps => TupleT (List.map what_type ps)
      | ConstructorP (s, p) => let val top = what_type p
                   in
                       case List.find (fn (x, _, _) => x = s) dts of
                       NONE => raise NoAnswer
                     | SOME (_, name, t) => if no_conflict (t, top)
                                then Datatype name
                                else raise Conflict
                   end

      fun change (aft, bfr) =
    case (aft, bfr) of
        (_, Anything) => aft
      | (Anything, _) => bfr
      | (TupleT ta, TupleT tb) => if List.length ta = List.length tb
                      then TupleT ((List.map change o ListPair.zip)
                               (ta, tb))
                      else raise Conflict
      | _ => if aft = bfr then aft else raise Conflict
  in
      SOME(List.foldl (fn (x, init) => change (what_type x, init)) Anything ps)
      handle NoAnswer => NONE
       | Conflict => NONE
  end
  
(* 
(* Construction site *)

val dts = [("red","color",Anything), ("green","color",Datatype "color"), ("blue","color",IntT), ("yellow","color",UnitT), ("foo1","bar",UnitT), ("foo2","bar",Datatype "color")]

fun no_conflict (t1, t2) =
  case (t1, t2) of
      (_, Anything) => true
    | (Anything, _) => true
    | (TupleT tb, TupleT ta) => (List.length tb = List.length ta)
                andalso
                (List.all no_conflict o ListPair.zip) (tb, ta)
    | _ => t1 = t2
            
fun what_type p =
  case p of
      Wildcard => Anything
    | Variable _ => Anything
    | UnitP => UnitT
    | ConstP _ => IntT
    | TupleP ps => TupleT (List.map what_type ps)
    | ConstructorP (s, p) => let val top = what_type p
                 in
                 case List.find (fn (x, _, _) => x = s) dts of
                     NONE => raise NoAnswer
                   | SOME (_, name, t) => if no_conflict (t, top)
                              then Datatype name
                              else raise Conflict
                 end

fun change (aft, bfr) =
  case (aft, bfr) of
      (_, Anything) => aft
    | (Anything, _) => bfr
    | (TupleT ta, TupleT tb) => if List.length ta = List.length tb
                then TupleT ((List.map change o ListPair.zip) (ta, tb))
                else raise Conflict
    | _ => if aft = bfr then aft else raise Conflict
*)