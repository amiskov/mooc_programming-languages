(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
(* 1.a *)
fun all_except_option (str, str_list) =
    case str_list of
        [] => NONE
      | head::tail => case same_string(str, head) of
                        true => SOME tail
                      | false => case all_except_option(str, tail) of
                                    NONE => NONE
                                  | SOME lst => SOME (head::lst);

(* 1.b *)
fun get_substitutions1 (substitutions, s) =
    case substitutions of
        [] => []
      | current_subs::all_other_subs =>
            case all_except_option(s, current_subs) of
                NONE => get_substitutions1(all_other_subs, s)
              | SOME lst => lst@get_substitutions1(all_other_subs, s);

(* 1.c *)
fun get_substitutions2 (substitutions, s) =
    let fun aux(substitutions, acc) =
        case substitutions of
            [] => acc
          | current_subs::all_other_subs =>
                case all_except_option(s, current_subs) of
                    NONE => aux(all_other_subs, acc)
                  | SOME lst => aux(all_other_subs, acc@lst)
    in
        aux(substitutions, [])
    end

(* 1.d *)
fun similar_names (substitutions, full_name) =
    let val {first=f, middle=m, last=l} = full_name;
        fun prepare_list (first_names) =
            case first_names of
                [] => []
              | fname::others =>
                  {first=fname, middle=m, last=l}::prepare_list(others)
    in
        case get_substitutions2(substitutions, f) of
            [] => []
          | fnames => prepare_list(f::fnames)
    end



(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)