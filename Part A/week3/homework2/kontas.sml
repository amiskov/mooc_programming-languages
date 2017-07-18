(* Christos Kontas, Coursera PL, HW2 Solution Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* Problem 1 solutions *)

(* Return `options` list excluding s.*)
fun all_except_option (s, options) =
   let
      fun aux ([], new_options) = NONE
        | aux (t::options, new_options) =
            if same_string (s, t) then
               SOME (new_options @ options)
            else
               aux (options, t::new_options)
   in
      aux (options, [])
   end

(* Return valid substitutions that don't contain s. *)
fun get_substitutions1 ([], s) = []
  | get_substitutions1 (sub::subs, s) =
      case all_except_option (s, sub) of
           NONE => get_substitutions1 (subs, s)
         | SOME found => found @ get_substitutions1 (subs, s)

(* Similar to get_substitutions1, but uses tail-recursion. *)
fun get_substitutions2 (substitutions, s) =
   let
      fun for_each ([], result) = result
        | for_each (sub::subs, result) =
              case all_except_option (s, sub) of
                   NONE => for_each (subs, result)
                 | SOME result' => for_each (subs, result @ result')
   in
      for_each (substitutions, [])
   end

fun similar_names ([], name) = [name]
  | similar_names (substitutions, {first=first, middle=middle, last=last}) =
      let
         fun for_each [] = []
           | for_each (name::names) =
                {first=name, middle=middle, last=last} :: for_each (names)

         val alternatives = get_substitutions1(substitutions, first)
      in
         for_each (first::alternatives)
      end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove


(* Problem 2 solutions *)

(* Return the color of a card (Red | Black). *)
fun card_color (Clubs, rank) = Black
  | card_color (Spades, rank) = Black
  | card_color (_, rank) = Red

fun card_color (Clubs, rank) = Black
  | card_color (Spades, rank) = Black
  | card_color (_, rank) = Red





(* Return the value of a card (its rank, or 11 for ACE, otherwise 10). *)
fun card_value (suit, Num n) = n
  | card_value (suit, Ace) = 11
  | card_value (suit, _) = 10

(* Remove first occurence of card from list of cards, otherwise raise e. *)
fun remove_card (cards, card, e) =
   let
      fun uniques ([], elem, new_items) = raise e
        | uniques (hd::items, elem, new_items) =
            if hd = elem then
               new_items @ items
            else
               uniques (items, elem, hd::new_items)
   in
      uniques (cards, card, [])
   end

(* Return true if both cards have the same color. *)
fun same_color (a, b) =
   card_color a = card_color b

fun cards_with_color ([], card) = true
  | cards_with_color (c::cs, card) =
      same_color (c, card) andalso cards_with_color (cs, card)

fun all_same_color [] = true
  | all_same_color (c::cs) = cards_with_color (cs, c)

(* Return the total number of values of all cards. *)
fun sum_cards cards =
   let
      fun sum ([], n) = n
        | sum (c::cs, n) = sum (cs, n + card_value c)
   in
      sum (cards, 0)
   end

fun preliminary_score (cards, goal) =
   let
      val sum = sum_cards cards
   in
      if sum > goal then
         3 * (sum - goal)
      else
         goal - sum
   end

fun score (cards, goal) =
   let
      val penalty = if all_same_color cards then 2 else 1
   in
      preliminary_score(cards, goal) div penalty
   end

fun officiate (cards, moves, goal) =
   let
      fun draw_card ([], held_cards) = ([], [])
        | draw_card(c::card_list, held_cards) =
            if sum_cards (c::held_cards) > goal then
               ([], c::held_cards)
            else
               (card_list, c::held_cards)

      fun game (card_list, held_cards, []) = score (held_cards, goal)
        | game (card_list, held_cards, (Discard card)::moves) =
            game (card_list, remove_card (held_cards, card, IllegalMove), moves)
        | game (card_list, held_cards, Draw::moves) =
               case draw_card (card_list, held_cards) of
                    ([], []) => score (held_cards, goal)
                  | ([], held_cards)  => score (held_cards, goal)
                  | (card_list, held_cards) => game (card_list, held_cards, moves)
   in
      game (cards, [], moves)
   end