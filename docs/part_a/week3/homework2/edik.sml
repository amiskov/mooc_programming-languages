(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* 1a *)
fun all_except_option(str, strs) =
    let
        fun exclude_str(strs, passed) =
            case strs of
                [] => NONE
                | x::strs' =>
                    if same_string(str, x)
                    then SOME (passed @ strs')
                    else exclude_str(strs', passed @ [x])
    in
        exclude_str(strs, [])
    end

(* 1b *)
fun get_substitutions1(strs_list, str) =
    case strs_list of [] => []
        | strs::strs_list' =>
            let val strs_result =
                case all_except_option(str, strs) of NONE => []
                    | SOME (x) => x
            in
                strs_result @ get_substitutions1(strs_list', str)
            end

(* 1c *)
fun get_substitutions2(strs_list, str) =
    let fun get_substitutions(strs_list, str, acc) =
        case strs_list of [] => acc
            | strs::strs_list' =>
                let val strs_result =
                    case all_except_option(str, strs) of NONE => []
                        | SOME (x) => x
                in
                    get_substitutions(strs_list', str, acc @ strs_result)
                end
    in
        get_substitutions(strs_list, str, [])
    end



(* 1d *)
fun similar_names(strs_list, {first=fname, middle=mname, last=lname}) =
    let fun similar_name(names) =
        case names of [] => []
            | name::names' => {first=name, middle=mname, last=lname}::similar_name(names')
    in
        {first=fname, middle=mname, last=lname}
            ::similar_name(get_substitutions2(strs_list, fname))
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

(* 2a *)
fun card_color((Clubs | Spades), _) = Black
    | card_color((Diamonds | Hearts), _) = Red

fun card_color (suit, rank) =
    case suit of (Diamonds | Hearts) => Red
    | _ => Black




(* 2b *)
fun card_value(_, rank) =
    case rank of Ace => 11
        | Num x => x
        | _ => 10

(* 2c *)
fun remove_card(cards, card, e) =
    let fun exclude_card([], acc) = raise e
        | exclude_card(c::cards', acc) =
            if c = card
            then acc @ cards'
            else exclude_card(cards', acc @ [c])
    in
        exclude_card(cards, [])
    end

(* 2d *)
fun all_same_color cards =
    case cards of [] => true
        | c::[] => true
        | c::(c'::cards') =>
            card_color c = card_color c' andalso all_same_color (c'::cards')

(* 2e *)
fun sum_cards cards =
    let fun sum(cards, acc) =
        case cards of [] => acc
            | card::cards' => sum(cards', acc + card_value card)
    in
        sum(cards, 0)
    end

(* 2f *)
fun score(cards, goal) =
    let
        val sum = sum_cards cards
        val preliminary_score =
            if sum > goal
            then 3 * (sum - goal)
            else goal - sum
    in
        if all_same_color cards
        then preliminary_score div 2
        else preliminary_score
    end

(* 2g *)
fun officiate(cards, moves, goal) =
    let fun step(cards, moves, helded_cards) =
        case moves of [] => score(helded_cards, goal)
            | (Discard card)::moves' =>
                step(remove_card(cards, card, IllegalMove), moves', helded_cards)
            | Draw::moves' =>
                case cards of [] => score(helded_cards, goal)
                    | card::cards' => if sum_cards(card::helded_cards) > goal
                        then score(card::helded_cards, goal)
                        else step(cards', moves', card::helded_cards)
    in
        step(cards, moves, [])
    end