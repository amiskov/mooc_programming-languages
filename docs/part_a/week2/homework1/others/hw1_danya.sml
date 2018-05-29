(* Get year part of the date *)
fun get_year(date: int * int * int) = 
  #1 date;

(* Get month part of the date *)
fun get_month(date: int * int * int) = 
  #2 date;

(* Get day part of the date *)
fun get_day(date: int * int * int) = 
  #3 date;

(* Helper array for month days *)
val month_days = [ 31 (* Jan *), 28 (* Feb *), 31 (* Mar *), 30 (* Apr *), 31 (* May *), 30 (* Jun *), 31 (* Jul *), 31 (* Aug *), 30 (* Sep *), 31 (* Oct *), 30 (* Nov *), 31 (* Dec *)] 

(* 1. Check if date x comes before date y *)
fun is_older(x: int * int * int, y: int * int * int) = 
  let
    val day_older = get_day(x) < get_day(y)
    val month_older = get_month(x) < get_month(y) orelse 
      (get_month(x) = get_month(y) andalso day_older)
  in
      get_year(x) < get_year(y) 
      orelse (get_year(x) = get_year(y) andalso month_older)
  end

(* 2. Count how many dates from the list are in the month *)
fun number_in_month(dates: (int * int * int) list, month: int) =
  if null dates then 0
  else 
    let 
      val currentNum = if get_month(hd dates) = month then 1 else 0
    in 
      currentNum + number_in_month(tl dates, month) 
    end

(* 3. Count how many dates from the list are in any of months *)
fun number_in_months(dates: (int * int * int) list, months: int list) =
  if null months then 0
  else 
    number_in_month(dates, hd months) + number_in_months(dates, tl months)

(* 4. Filter dates list by month *)
fun dates_in_month(dates: (int * int * int) list, month: int) =
  if null dates then []
  else 
    let 
      val next_result = dates_in_month(tl dates, month)
     in
       if get_month(hd dates) = month 
       then hd dates :: next_result 
       else next_result
    end

(* 5. Filter dates list by matching any of months *)
fun dates_in_months(dates: (int * int * int) list, months: int list) =
  if null months then []
  else
    dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

(* 6. Get nth element from the list of strings *)
fun get_nth(strs: string list, n: int) =
  let
    fun traverse(s: string list, idx: int) =
      if idx = n then hd s else traverse(tl s, idx + 1)
  in
    traverse(strs, 1)
  end

(* 7. Represent date as a string *)
fun date_to_string(date: (int * int * int)) =
  let
    val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    val month = get_nth(months, get_month(date))
    val day   = Int.toString(get_day(date))
    val year  = Int.toString(get_year(date))
  in
     month ^ " " ^ day ^ ", " ^ year
  end

(* 8. Get n such that the first n elements of the list add to less than sum *)
fun number_before_reaching_sum(sum: int, nums: int list) =
  let
    fun check_sum(next_nums: int list, idx: int, current_sum: int) = 
      if current_sum >= sum
      then idx - 1
      else check_sum(tl next_nums, idx + 1, current_sum + hd next_nums);
  in
    check_sum(nums, 0, 0)
  end

(* 9. Get month by day in a year *)
fun what_month(day: int) = 
    number_before_reaching_sum(day, month_days) + 1

(* 10. Get months within year days range *)
fun month_range(day1: int, day2: int) =
  if day1 > day2 then []
  else
    what_month(day1) :: month_range(day1 + 1, day2)

(* 11. Get oldest date *)
fun oldest(dates: (int * int * int) list) =
    if null dates then NONE
    else 
      let
        fun oldest_nonempty(dates: (int * int * int) list) =
          if null(tl dates) then hd dates
          else 
            let val tail_result = oldest_nonempty(tl dates)
            in
              if is_older(hd dates, tail_result) 
              then hd dates 
              else tail_result
            end
      in
        SOME(oldest_nonempty(dates))
      end

(* Helper function for challenge #12.a and #12.b *)
fun remove_month_dups(months: int list) = 
  let
    fun is_in_list(months: int list, month: int) = 
      if null months then false
      else 
        if hd months = month then true
        else is_in_list(tl months, month)
  in
    if null months then []
    else 
      if is_in_list(tl months, hd months) 
      then remove_month_dups(tl months)
      else hd months :: remove_month_dups(tl months)
  end


(* 12.a Count how many dates from the list are in any of months *)
fun number_in_months_challenge(dates: (int * int * int) list, months: int list) =
    number_in_months(dates, remove_month_dups(months))

(* 12.b Filter dates list by matching any of months *)
fun dates_in_months_challenge(dates: (int * int * int) list, months: int list) =
    dates_in_months(dates, remove_month_dups(months))

(* 13. Check if date is reasonable *)
fun reasonable_date(date: (int * int * int)) =
  let
    fun get_month_days(date: (int * int * int)) =
      let
        fun get_nth(nums: int list, n: int) =
          let
            fun traverse(nums: int list, idx: int) =
              if idx = n then hd nums else traverse(tl nums, idx + 1)
          in
            traverse(nums, 1)
          end

        fun is_leap(year: int) = 
            year mod 400 = 0
            orelse 
            (
              year mod 4 = 0 andalso year mod 100 <> 0
            )
      in
        if get_month(date) = 2 (* Feb *) andalso is_leap(get_year date)
            then 29
            else get_nth(month_days, get_month(date))
      end
  in
    get_year(date) > 0 
    andalso get_month(date) >= 1 
    andalso get_month(date) <= 12 
    andalso get_day(date) >= 1 
    andalso get_day(date) <= get_month_days(date)
  end