(* Homework1 Solution *)

(* 1 *)
fun is_older (date1 : int * int * int, date2 : int * int * int) =
  #1 date1 < #1 date2
  orelse (#1 date1 = #1 date2 andalso #2 date1 < #2 date2)
  orelse (#1 date1 = #1 date2 andalso #2 date1 = #2 date2 andalso #3 date1 < #3 date2)

(* 2 *)
fun number_in_month (datelist : (int * int * int) list, month : int) =
  if null datelist
  then 0
  else if #2 (hd datelist) = month
  then 1 + number_in_month (tl datelist,month)
  else number_in_month (tl datelist,month)

(* 3 *)
fun number_in_months (datelist : (int * int * int) list, monthlist : int list) =
  if null monthlist
  then 0
  else number_in_month (datelist,hd monthlist) + number_in_months (datelist,tl monthlist)

(* 4 *)
fun dates_in_month (datelist : (int * int * int) list, month : int) =
  if null datelist
  then []
  else if #2 (hd datelist) = month
  then (hd datelist) :: dates_in_month (tl datelist,month)
  else dates_in_month (tl datelist,month)

(* 5 *)
fun dates_in_months (datelist : (int * int * int) list, monthlist : int list) =
  if null monthlist
  then []
  else dates_in_month (datelist,hd monthlist) @ dates_in_months (datelist,tl monthlist)

(* 5 *)
fun get_nth (strlist : string list, n : int) =
  if n = 1
  then hd strlist
  else get_nth (tl strlist,n-1)

(* 7 *)
fun date_to_string (date : int * int * int) =
  let
      val months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
  in
      get_nth (months,(#2 date)) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
  end

(* 8 *)
fun number_before_reaching_sum (target : int, list : int list) =
  if hd list >= target
  then 0
  else 1 + number_before_reaching_sum (target - (hd list),tl list)

(* 9 *)
fun what_month (day : int) =
  let
      val days = [31,28,31,30,31,30,31,31,30,31,30,31]
  in
      1 + number_before_reaching_sum (day, days)
  end

(* 10 *)
fun month_range (day1 : int, day2 : int) =
  if day1 > day2
  then []
  else what_month(day1) :: month_range (day1+1,day2)

(* 11 *)
fun oldest (dates : (int * int * int) list) =
  if null dates
  then NONE
  else let
      val rest = oldest (tl dates)
  in
      if isSome rest andalso is_older (valOf rest,hd dates)
      then rest
      else SOME (hd dates)
  end


(* Challenge Question Solutions *)

(* Helper function for challenge 12 *)
fun remove_duplicate (list : int list) =
  let
      fun check_duplicate (i : int, list : int list) =
	if null list
	then false
	else i = hd list orelse check_duplicate (i, tl list)
  in
      if null list
      then []
      else if check_duplicate (hd list, tl list)
      then remove_duplicate (tl list)
      else (hd list) :: remove_duplicate (tl list)
  end

fun number_in_months_challenge (datelist : (int * int * int) list, monthlist : int list) =
  number_in_months (datelist,remove_duplicate(monthlist))

fun dates_in_months_challenge (datelist: (int * int * int) list, monthlist : int list) =
  dates_in_months (datelist,remove_duplicate(monthlist))

fun reasonable_date (date : int * int * int) =
  if #1 date <= 0 orelse #2 date < 1 orelse #2 date > 12
  then false
  else let
      fun get_nth (list : int list, n : int) =
	if n = 1
	then hd list
	else get_nth (tl list,n-1)
      val feb = if (#1 date) mod 400 = 0 orelse (#1 date mod 4 = 0 andalso #1 date mod 100 <> 0)
		then 29
		else 28
      val days = [31,feb,31,30,31,30,31,31,30,31,30,31]
  in
      #3 date >= 1 andalso #3 date <= get_nth (days,#2 date)
  end
