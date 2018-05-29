function filterStrings(strs, s) {
    const l = s.length; // сохранили переменную, чтоб не вычислять
                        // длину заданной строки каждый раз
    return strs.filter((str) => str.length < l);
}

console.log(
    filterStrings(['hello', 'ololo', 'test'], 'test long')
);


function between(lo, hi, xs) {
    return xs.reduce((acc, curr) => {
        return acc += ((curr >= lo && curr <= hi) ? 1 : 0);
    }, 0);
}
console.log(between(1, 5, [-2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8]));