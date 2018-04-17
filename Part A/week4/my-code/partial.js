// Каррирование
const addN = (n) => (numbers) => numbers.map(el => el + n);

// Частичное применение
const addOne = addN(1);

console.log(addOne([1, 2, 3]));

