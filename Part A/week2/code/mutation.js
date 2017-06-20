const x = [1, 2, 3];
const y = x;
console.log(y == x); // true

y.push(4);
console.log(y == x); // true, оба поменялись
