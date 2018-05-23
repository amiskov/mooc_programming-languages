(* 1 *)
fun is_older(a : int * int * int, b : int * int * int) =
  if #1 a <> #1 b
  then #1 a < #1 b
  else
    if #2 a <> #2 b
    then #2 a < #2 b
    else #3 a < #3 b;

(* 2 *)
fun number_in_month(dates : (int * int * int) list, month : int) =
  if null dates
  then 0
  else
    (if #2 (hd dates) = month then 1 else 0) + number_in_month(tl dates, month);

(* 3 *)
fun number_in_months(dates : (int * int * int) list, months : int list) =
  if null months
  then 0
  else number_in_month(dates, hd months) + number_in_months(dates, tl months);

(* 4 *)
fun dates_in_month(dates : (int * int * int) list, month : int) =
  if null dates
  then []
  else if #2 (hd dates) = month
    then (hd dates)::dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month);

(* 5 *)
fun dates_in_months(dates : (int * int * int) list, months : int list) =
  if null months
  then []
  else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months);

(* 6 *)
fun get_nth(strings : string list, n : int) =
  if n <= 1
  then hd strings
  else get_nth(tl strings, n - 1);

(* 7 *)
fun date_to_string(date : int * int * int) =
  let
    val months = [
      "January", "February", "March", "April", "May", "June", "July", "August",
      "September", "October", "November", "December"
    ]
  in
    get_nth(months, #2 date) ^ " " ^ Int.toString(#3 date)
      ^ ", " ^ Int.toString(#1 date)
  end;

(* 8 *)
fun number_before_reaching_sum(sum : int, numbers : int list) =
  if hd numbers >= sum
  then 0
  else 1 + number_before_reaching_sum(sum - hd numbers, tl numbers);

(* 9 *)
fun what_month(day : int) =
  let
    val days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  in
    number_before_reaching_sum(day, days) + 1
  end;

(* 10 *)
fun month_range(day1 : int, day2 : int) =
  if day1 <= day2
  then what_month(day1)::month_range(day1 + 1, day2)
  else [];

(* 11 *)
fun oldest(dates : (int * int * int) list) =
  if null dates
  then NONE
  else
    let
      fun oldest_nonempty(dates: (int * int * int) list) =
        if null (tl dates)
        then hd dates
        else
          let
            val tl_oldest = oldest_nonempty(tl dates)
          in
            if not (is_older(hd dates, tl_oldest))
            then tl_oldest
            else hd dates
          end
    in
      SOME (oldest_nonempty dates)
    end;
