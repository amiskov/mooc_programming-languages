
let x = 1;

function f1(n) {
    return x + y + n;
}

const f2 = function(n) {
    return x + y + n;
}

let y = 3; // почему `f1` видит `y`?

/*
Потому что 
*/

console.log(f1(1)); // => 5
console.log(f2(1)); // => 5


