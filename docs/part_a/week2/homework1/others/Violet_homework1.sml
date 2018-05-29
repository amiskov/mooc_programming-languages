(* 1 *)
(* (int * int * int *(int * int * int) --> bool *)
fun is_older (date1 : int * int * int, date2 : int * int * int)=
  if  #1 date1 =  #1 date2
  then
      if #2 date1 = #2 date2
      then
    	  if #3 date1 = #3 date2
    	  then false
    	  else #3 date1 < #3 date2
      else #2 date1 < #2 date2
  else #1 date1 < #1 date2

(* 2 *)
(*(int*int*int) list, int --> int*)
fun number_in_month (dates: (int * int * int) list, month: int) =
  if null dates
  then 0
  else
      if #2 (hd dates) = month
      then 1 + number_in_month(tl(dates), month)
      else 0 + number_in_month(tl(dates), month)

(* 3 *)
fun number_in_months (dates: (int * int * int) list, months: int list) =
  if null (tl months)
  then
      number_in_month (dates, hd months)
  else
  number_in_month(dates, hd months) + number_in_months(dates,tl months)

(* 4 *)
fun dates_in_month (dates: (int * int * int) list, month: int) =
  if null dates
  then []
  else
	   if #2 (hd dates) = month
	   then hd dates :: dates_in_month(tl(dates), month)
	   else
	       dates_in_month(tl(dates), month)

(* 5 *)
fun dates_in_months (dates: (int * int * int) list, months: int list) =
  if null (tl months)
  then
      dates_in_month(dates, hd months)
  else
      dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

(* 6 *)
fun get_nth (strings: string list, n: int) =
  if n <> 1
  then
      get_nth (tl strings, n-1)
  else hd strings

(* 7 *)
fun date_to_string (date: int * int * int)=
  let val months = ["January ", "February ", "March ", "April ", "May ", "June ", "July "
		    , "August ", "September ", "October ", "November ", "December "]
  in
      get_nth(months, #2 date)^(Int.toString(#3 date))^(", ")^(Int.toString(#1 date))
  end

(* 8 *)
fun number_before_reaching_sum (sum : int, numbers: int list) =
  if null numbers
  then 0
  else
      let
        val ans_tl = number_before_reaching_sum(sum - hd numbers, tl numbers)
      in 
    	  if sum - hd numbers > 0
    	  then
    	      1 +  ans_tl
    	  else
    	      ans_tl
      end
     

(* 9 *)
fun what_month (day: int) =
  let val days = [31,28,31,30,31,30,31,31,30,31,30,31]
  in
      number_before_reaching_sum(day,days)+1
  end
      

(* 10 *)
fun month_range (day1: int, day2: int) =
  if day1 > day2
  then
      []
  else if day1 = day2
  then [what_month(day2)]		     
  else
      let
        val month1 = what_month(day1)
      in
    	  month1 :: month_range(day1+1,day2)		 
      end
	  
fun oldest (dates : (int * int * int) list) =
  if null dates
  then NONE
  else if null (tl dates)
  then SOME(hd dates)
  else
     let val old = hd dates
	 val ans_tl = oldest(tl dates)
     in
	 if is_older(old, valOf ans_tl)
	 then
	     SOME(old)
	 else
	     ans_tl
     end

 fun remove_dup(months: int list) =
	if null (tl months)
	then months
	else
	    let fun same(A: int, B:int list) =
		  if null(tl B)
		  then
		      if A = hd B
		      then []
		      else
			  [A]
		  else
		      if A = hd B
		      then []
		      else
			  same(A, tl B)
	    in
		same(hd months, tl months)@remove_dup(tl months)
	    end


		
fun number_in_months_challenge (dates: (int * int * int) list, months: int list) = 
  let val months_remove = remove_dup(months)
  in
      number_in_months (dates, months_remove)
  end

fun dates_in_months_challenge (dates: (int * int * int) list, months: int list)=
  let val months_remove = remove_dup(months)
  in
     dates_in_months(dates, months_remove)
  end

fun get_nth_digit (numbers: int list, n: int) =
  if n <> 1
  then
      get_nth_digit (tl numbers, n-1)
  else hd numbers

fun reasonable_date(date: (int * int * int)) =
  if #1 date < 1
  then false
  else
      if #2 date > 0 andalso #2 date < 13
      then
	  if (#1 date mod 400) = 0 orelse
	     (((#1 date mod 4) = 0) andalso (not (#1 date mod 100 = 0)))
	  then
	      let val days_leap = [31,29,31,30,31,30,31,31,30,31,30,31]
	      in
		  if #3 date <= get_nth_digit(days_leap, #2 date)
		  then true
		  else
		      false
	      end
	  else
	      let val days = [31,28,31,30,31,30,31,31,30,31,30,31]
	      in
		  if #3 date <= get_nth_digit(days, #2 date)
		  then true
		  else
		      false
	      end
      else
	  false
	      
	  
			 
				      
