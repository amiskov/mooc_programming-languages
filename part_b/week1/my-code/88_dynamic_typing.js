const assert = require('assert')

const numbers = [1, 2, 3, [4, 5, [6, 7]], 8, [9, 10]];

// Сумма чисел в числовом массиве
function sum(numbers) {
    if (numbers.length === 0) {
        return 0;
    }

    if (typeof numbers[0] === 'number') {
        return numbers[0] + sum(numbers.slice(1));
    } else {
        return sum(numbers.slice(1)) + sum(numbers[0]);
    }
}

assert.equal(sum(numbers), (1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10));
console.log(sum(numbers));

// Сумма чисел в массиве, где есть не только числа
const arr = [1, "2", 3, [4, 5, [6, 7]], "8", [9, 10]];

function sum2(arr) {
    if (arr.length === 0 || !Array.isArray(arr)) {
        return 0;
    }

    const head = arr[0];
    const tail = arr.slice(1);

    if (typeof head === 'number') {
        return head + sum2(tail);
    } else if (Array.isArray(head)) {
        return sum2(head) + sum2(tail);
    }

    return sum2(tail);
}

assert.equal(sum2(arr), (1 + 3 + 4 + 5 + 6 + 7 + 9 + 10));
console.log(sum2(arr));
console.log(sum2('test'));
console.log(sum2(3));
