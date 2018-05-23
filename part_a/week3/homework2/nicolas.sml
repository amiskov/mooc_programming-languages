(* Problem 1a *)

fun all_except_option (the_word, words) =
    case words of
        [] => NONE
      | word::words' => if same_string(the_word, word)
                        then SOME words'
                        else case all_except_option (the_word, words') of
                                 NONE => NONE
                               | SOME words'' => SOME (word::words'')

(* Problem 1b *)

fun get_substitutions1 (substitutions, s) =
    case substitutions of
        [] => []
      | words::substitutions' => (case all_except_option(s, words) of
                                      NONE => []
                                    | SOME wrds => wrds) @ get_substitutions1 (substitutions', s)

(* Problem 1c *)

fun get_substitutions2 (substitutions, s) =
    let fun aux (substitutions, acc) =
            case substitutions of
                [] => acc
              | words::substitutions' => aux (substitutions', (case all_except_option(s, words) of
                                                                   NONE => []
                                                                 | SOME wrds => wrds) @ acc)
    in
        aux (substitutions, [])
    end

(* Problem 1d *)

fun similar_names (substitutions, full_name) =
    case full_name of
        {first=f, middle=m, last=l} =>
        let
        fun aux (subs) =
                case subs of
                    [] => []
                  | sub::subs' => {first=sub, middle=m, last=l}::aux subs'
        in
            full_name::aux (get_substitutions1 (substitutions, f))
        end

(* Problem 2a *)

fun card_color card =
    case card of
        (Clubs, _) => Black
      | (Diamonds, _) => Red
      | (Hearts, _) => Red
      | (Spades, _) => Black

(* Problem 2b *)

fun card_value card =
    case card of
        (_, Ace) => 11
      | (_, Num(n)) => n
      | (_,_) => 10

(* Problem 2c *)

fun remove_card (cs, c, e) =
    case cs of
        [] => raise e
      | t::cs' => if t = c
                  then cs'
                  else t::remove_card (cs', c, e)

(* Problem 2d *)

fun all_same_color cards =
    case cards of
        [] => true
      | _::[] => true
      | card0::card1::cards' =>
         card_color card0 = card_color card1
         andalso all_same_color(card1::cards')

(* Problem 2e *)

fun sum_cards cards =
    let fun aux (cards, acc) =
            case cards of
                [] => acc
              | card::cards' => aux (cards', acc + card_value card)
    in
        aux (cards, 0)
    end

(* Problem 2f *)

fun score (held_cards, goal) =
    let
        val sum = sum_cards held_cards
        val preliminary_score = if sum > goal
                                then 3 * (sum - goal)
                                else goal - sum
    in
        if all_same_color held_cards
        then preliminary_score div 2
        else preliminary_score
    end

(* Problem 2g *)

fun officiate (cards, moves, goal) =
    let
        fun play (cards, moves, held_cards) =
            case moves of
                [] => held_cards
              | move::moves' => case move of
                                    Discard c => play (cards, moves', remove_card (held_cards, c, IllegalMove))
                                  | Draw => case cards of
                                                [] => held_cards
                                              | card::cards' =>
                                                if sum_cards held_cards > goal
                                                then held_cards
                                                else play (cards', moves', card::held_cards)
    in
        score (play (cards, moves, []), goal)
    end