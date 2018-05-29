(* Write a function `all_except_option`, which takes a string and a string list.
Return `NONE` if the string is not in the list, else return `SOME lst`
where `lst` is identical to the argument list except the string is not in it.
You may assume the string is in the list at most once. Use `same_string`,
provided to you, to compare strings. Sample solution is around 8 lines. *)

(* ====================== Part 1 ====================== *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* 1.a *)
fun all_except_option (str, str_list) =
    case str_list of
        [] => NONE
      | head::tail => case same_string(str, head) of
                        true => SOME tail
                      | false => case all_except_option(str, tail) of
                                    NONE => NONE
                                  | SOME lst => SOME (head::lst)

(*val test1a = all_except_option ("string", ["hello", "ololo", "string"])
val test1a_1 = all_except_option ("string", ["string"]) = SOME [] *)

(* 1.b *)
fun get_substitutions1 (substitutions, s) =
    case substitutions of
        [] => []
      | current_subs::all_other_subs =>
            case all_except_option(s, current_subs) of
                NONE => get_substitutions1(all_other_subs, s)
              | SOME lst => lst@get_substitutions1(all_other_subs, s)

(*val test1b = get_substitutions1([
    ["Fred","Fredrick"],
    ["Elizabeth","Betty"],
    ["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"] *)

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

(*val test1c = get_substitutions2([
    ["Fred","Fredrick"],
    ["Elizabeth","Betty"],
    ["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"]
*)
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

(*val test1d = similar_names([
        ["Fred","Fredrick"],
        ["Elizabeth","Betty"],
        ["Freddie","Fred","F"]
    ], {first="Fred", middle="W", last="Smith"}) = [
        {first="Fred", last="Smith", middle="W"},
        {first="Fredrick", last="Smith", middle="W"},
        {first="Freddie", last="Smith", middle="W"},
        {first="F", last="Smith", middle="W"}
    ];

*)(*val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
        [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
         {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]
*)

(* ====================== Part 2 ====================== *)
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

(* 2.a *)
fun card_color_ (suit, rank) =
    case suit of
        Diamonds => Red
      | Hearts => Red
      | _ => Black

fun card_color (suit, rank) =
    case suit of
        (Diamonds | Hearts) => Red
        | _ => Black

(*val test5 = card_color (Clubs, Num 2) = Black*)

(* 2.b *)
fun card_value (suit, rank) =
    case rank of
        Ace => 11
        | Num n => n
        | _ => 10;

(*val test6 = card_value (Clubs, Num 2) = 2
val test61 = card_value (Clubs, Ace) = 11
val test62 = card_value (Diamonds, Jack) = 10
*)

(* 2.c *)
fun remove_card (cs, c, e) =
    case cs of
        [] => raise e
      | head_card::tail_cards => if (c = head_card)
                                 then tail_cards
                                 else head_card::remove_card(tail_cards, c, e);

(*val test7 = remove_card ([
    (Hearts, Ace), (Diamonds, Ace)
    ],
    (Diamonds, Ace), IllegalMove)
*)

(* 2.d *)
fun all_same_color cs =
    case cs of
        [] => true
      | _::[] => true
      | head_card::(neck_card::tail_cards) =>
            (card_color(head_card) = card_color(neck_card))
            andalso all_same_color(neck_card::tail_cards)

val test8 = all_same_color [(Hearts, Ace), (Diamonds, Ace), (Hearts, Ace)] = true

(* 2.e*)
fun sum_cards cs =
    let fun count (cs, acc) =
            case cs of
                [] => acc
              | head_card::tail_cards =>
                  count(tail_cards, card_value(head_card) + acc)
    in
        count(cs, 0)
    end

(*val test9 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4*)

(* 2.f *)
(*fun score (cs, goal) =
    let
        fun count_preliminary(delta) =
            if delta > 0
            then delta * 3
            else if delta = 0
                 then 0
                 else ~delta;
        val preliminary = count_preliminary(sum_cards(cs) - goal)
    in
        if all_same_color(cs)
        then preliminary div 2
        else preliminary 
    end
*)

(* 2.f *)
fun score (cs, goal) =
    let
        fun count_preliminary (sum) =
            if sum > goal
            then (sum - goal) * 3
            else goal - sum
        val preliminary = count_preliminary(sum_cards(cs))
    in
        if all_same_color(cs)
        then preliminary div 2
        else preliminary 
    end

(*val test10 = score ([(Hearts, Num 2),(Clubs, Num 4)], 10) = 4 *)

(* 2.g *)
fun officiate (cs, moves, goal) =
    let fun play(cs, moves, held_cards) =
        if sum_cards(held_cards) > goal
        then score(held_cards, goal)
        else case moves of
            [] => score(held_cards, goal)
          | (Discard c)::tail_moves =>
                play(cs, tail_moves, remove_card(held_cards, c, IllegalMove))
          | Draw::tail_moves =>
                case cs of
                    [] => score(cs, goal)
                  | head_card::tail_cards =>
                        play(cs, tail_moves, head_card::held_cards)
    in
        play(cs, moves, [])
    end


val test11 = officiate ([
    (Hearts, Num 2),
    (Clubs, Num 4)],
    [Draw], 15) = 6;

