import strutils
import math
import sequtils

const EOL: string = ""

proc solve_first_part() =
    let file = open("inputs/input1.txt")
    defer: file.close()

    var
        current_max, current_total: int
        line: string

    while file.read_line(line):
        if line == EOL:
            if current_total > current_max:
                current_max = current_total
            current_total = 0
            continue

        let food_amount = parseInt(line)
        current_total += food_amount

    echo "The answer for the first part is: ", current_max

proc solve_second_part() =
    let file = open("inputs/input1.txt")
    defer: file.close()

    var
        current_top_three = [0, 0, 0]
        current_total: int
        line: string

    while file.read_line(line):
        if line == EOL:
            let index_min_amount = minIndex(current_top_three)

            if current_total > current_top_three[index_min_amount]:
                current_top_three[index_min_amount] = current_total

            current_total = 0
            continue

        let food_amount = parseInt(line)
        current_total += food_amount

    let top_three_sum = sum(current_top_three)
    echo "The answer for the second part is: ", top_three_sum

solve_first_part()
solve_second_part()
