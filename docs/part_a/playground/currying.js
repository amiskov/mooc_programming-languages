/* Каррирование или карринг (англ. currying) — преобразование функции от многих
аргументов в набор функций, каждая из которых является функцией от одного аргумента.
*/

// Пример не каррированной функции.
// Вернет `true`, если значения идут по порядку:
const sorted = (x, y, z) => {
    return (x <= y) && (y <= z);
};
console.log(sorted(7, 8, 9));

// то же самое, но через 3 функции (каррирование):
const sortedCurried = (x) => (y) => (z) => (x <= y) && (y <= z);

// `sortedCurried` через синтаксис ES5, возможно понятнее:
function sortedCurriedOld(x) {
    return function(y) {
        return function(z) {
            return (x <= y) && (y <= z);
        }
    }
}
console.log(sortedCurriedOld(7)(8)(9));

// Зачем?
// Чтобы можно было делать частичное применение — создавать фукнции на основе других
// функций, но без каких-то аргументов.

// Например на основе `sortedCurried` можно создать функцию, которая проверяет,
// положительное ли число передано:
const nonNegative = sortedCurried(0)(0);
console.log(nonNegative(-3)); // false, сравнило с нулями

/*
В 4-й главе используется хелпер-функция из Lodash, вот тут она разбирается:
https://medium.com/@kj_huang/implementation-of-lodash-curry-function-8b1024d71e3b

В чисто-функциональных языках синтаксис для каррирования проще.
Например, из Meta Language:

fun sorted3 x y z = x <= y andalso y <= z
*/
