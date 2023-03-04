import strutils
import sequtils
import strscans

type Stack = seq[char]

const STACK_COUNT = readLines("inputs/input5.txt", 1)[0].len() div 4 + 1

proc solve*() =
    let file = open("inputs/input5.txt")
    defer: file.close()

    var
        line: string
        supplies_first_part: array[STACK_COUNT, Stack]
        supplies_second_part: array[STACK_COUNT, Stack]
        final_message_first_part: string = ""
        final_message_second_part: string = ""

    while file.read_line(line):
        for i, c in line.pairs:
            if c == '[':
                supplies_first_part[i div 4].insert(line[i + 1])
                supplies_second_part[i div 4].insert(line[i + 1])

        var
            move_count: int
            move_from: int
            move_to: int
        if scanf(line, "move $i from $i to $i", move_count, move_from, move_to):
            for _ in 1..move_count:
                let crate_to_rearrange = supplies_first_part[move_from - 1].pop
                supplies_first_part[move_to - 1].add(crate_to_rearrange)

            let creates_to_rearrange = supplies_second_part[move_from - 1][
                    ^move_count..^1]
            supplies_second_part[move_to - 1].add(creates_to_rearrange)
            supplies_second_part[move_from - 1].setLen(supplies_second_part[
                    move_from - 1].len - move_count)

    final_message_first_part = supplies_first_part.mapIt(it[^1]).join
    final_message_second_part = supplies_second_part.mapIt(it[^1]).join

    echo "The answer for the first part is: ", final_message_first_part
    echo "The answer for the second part is: ", final_message_second_part

if isMainModule:
    solve()
