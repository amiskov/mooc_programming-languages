fun is_older (d1: int*int*int, d2: int*int*int) =
    if #1 d1 = #1 d2 andalso #2 d1 = #2 d2 then #3 d1 < #3 d2
    else if #1 d1 = #1 d2 then #2 d1 < #2 d2
    else #1 d1 < #1 d2

fun number_in_month (d_list: (int*int*int) list, m: int) =
    if null d_list then 0
    else (if #2 (hd d_list) = m then 1 else 0) + number_in_month(tl d_list, m)

fun number_in_months (d_list: (int*int*int) list, m_list: int list) =
    if null m_list then 0
    else number_in_month(d_list, hd m_list) + number_in_months(d_list, tl m_list)

fun dates_in_month (d_list: (int*int*int) list, m: int) =
    if null d_list then []
    else
        if #2 (hd d_list) = m then hd d_list :: dates_in_month(tl d_list, m)
        else dates_in_month(tl d_list, m)

fun dates_in_months (d_list: (int*int*int) list, m_list: int list) =
    let fun append (d_list1: (int*int*int) list, d_list2: (int*int*int) list) =
        if null d_list1 then d_list2
        else hd (d_list1) :: append (tl(d_list1), d_list2)
    in
        if null m_list then []
        else append(dates_in_month(d_list, hd m_list), dates_in_months(d_list, tl m_list))
    end

fun get_nth (array: string list, n: int) =
    if n = 1 then hd array
    else get_nth(tl array, n - 1)

fun date_to_string(date: int*int*int) = 
    get_nth(["January", "February", "March", "April", "May", "June", "July", "August", "September",
        "October", "November", "December"], #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)

fun number_before_reaching_sum (sum: int, nums: int list) = 
    let fun count_down(sum: int, nums: int list, n:int) =
        if (sum <= 0) then n
        else count_down(sum - hd nums, tl nums, n + 1)
    in
        count_down(sum, nums, 0) - 1
    end

fun what_month(n: int) =
    number_before_reaching_sum(n, [31,28,31,30,31,30,31,31,30,31,30,31]) + 1

fun month_range(day1: int, day2: int) =
    if day1 > day2 then []
    else what_month(day1) :: month_range(day1 + 1, day2)

fun oldest (d_list: (int*int*int) list) =
    if null d_list then NONE
    else let
        fun find_max (d_list: (int*int*int) list) =
            if null (tl d_list) then hd d_list
            else let val tl_ans = find_max(tl d_list)
            in
                if is_older(hd d_list, tl_ans) then hd d_list
                else tl_ans
            end
    in
        SOME (find_max d_list)
    end