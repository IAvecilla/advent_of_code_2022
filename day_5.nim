import strutils
import sequtils
import strscans

type Stack = seq[char]

const STACK_COUNT = readLines("inputs/input5.txt", 1)[0].len() div 4 + 1

proc solve_first_part() =
    let file = open("inputs/input5.txt")
    defer: file.close()

    var
        line: string
        supplies: array[STACK_COUNT, Stack]
        final_message: string = ""

    while file.read_line(line):
        for i, c in line.pairs:
            if c == '[':
                supplies[i div 4].insert(line[i + 1])

        var
            move_count: int
            move_from: int
            move_to: int
        if scanf(line, "move $i from $i to $i", move_count, move_from, move_to):
            for _ in 1..move_count:
                let crate_to_rearrange = supplies[move_from - 1].pop
                supplies[move_to - 1].add(crate_to_rearrange)


    final_message = supplies.mapIt(it[^1]).join
    echo "The answer for the first part is: ", final_message

proc solve_second_part() =
    let file = open("inputs/input5.txt")
    defer: file.close()

    var
        line: string
        supplies: array[STACK_COUNT, Stack]
        final_message: string = ""

    while file.read_line(line):
        for i, c in line.pairs:
            if c == '[':
                supplies[i div 4].insert(line[i + 1])

        var
            move_count: int
            move_from: int
            move_to: int
        if scanf(line, "move $i from $i to $i", move_count, move_from, move_to):

            let creates_to_rearrange = supplies[move_from - 1][^move_count..^1]
            supplies[move_to - 1].add(creates_to_rearrange)
            supplies[move_from - 1].setLen(supplies[move_from - 1].len - move_count)

    final_message = supplies.mapIt(it[^1]).join
    echo "The answer for the second part is: ", final_message


solve_first_part()
solve_second_part()
