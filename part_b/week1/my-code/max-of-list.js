const maxOfList = nums => {
    const [head, ...tail] = nums;

    if (nums.length === 0) {
        return 'Given an empty list.'
    }

    if (tail.length === 0) {
        return head
    }

    const max = maxOfList(tail)
    return (max > head) ? max : head;
}

console.log(maxOfList([2, 0, 6])); // 6
console.log(maxOfList([])); // Given an empty list
console.log(maxOfList([3])); // 3
