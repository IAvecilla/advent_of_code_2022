import strutils
import math
import sequtils

const EOL: string = ""

proc solve*() =
    let file = open("inputs/input1.txt")
    defer: file.close()

    var
        current_max, current_total: int
        current_top_three = [0, 0, 0]
        line: string

    while file.read_line(line):
        if line == EOL:
            if current_total > current_max:
                current_max = current_total

            let index_min_amount = minIndex(current_top_three)
            if current_total > current_top_three[index_min_amount]:
                current_top_three[index_min_amount] = current_total

            current_total = 0
            continue

        let food_amount = parseInt(line)
        inc current_total, food_amount

    let top_three_sum = sum(current_top_three)
    echo "The answer for the first part is: ", current_max
    echo "The answer for the second part is: ", top_three_sum

if isMainModule:
    solve()
