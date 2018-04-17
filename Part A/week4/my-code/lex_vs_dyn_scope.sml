fun f g =
    let
        val x = 9
    in
        g()
    end

val x = 7

fun h() = x + 1;

val y = f h;

print "hello";