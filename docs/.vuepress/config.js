module.exports = {
    title: 'Programming Languages',
    description: 'Introduction to the basic concepts of programming languages, with a strong emphasis on functional programming',
    base: '/mooc_programming-languages/',
    themeConfig: {
        base: '/mooc_programming-languages/',
        // lastUpdated: 'Last Updated',
        sidebar: [{
            title: 'Part A (ML)',
            collapsable: false,
            children: [
                '/part_a/',
                '/part_a/week1/',
                '/part_a/week2/',
                '/part_a/week3/',
                '/part_a/week4/',
                '/part_a/week5/',
            ]
        }, {
            title: 'Part B (Racket)',
            collapsable: false,
            children: [
                '/part_b/',
                '/part_b/week1/',
            ]
        }]
    }
}