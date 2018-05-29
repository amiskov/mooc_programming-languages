// val sqrt_of_abs = Math.sqrt o Real.fromInt o abs; (* Ok *)

const sqrtOfAbs = (i) => Math.sqrt(parseInt(Math.abs(i)));

console.log(sqrtOfAbs(-10));