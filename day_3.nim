import sequtils
import strutils

proc solve_first_part() =
    let file = open("inputs/input3.txt")
    defer: file.close()

    var
        line: string
        total_priority: int
    while file.read_line(line):
        let
            items_count = line.len()
            first_compartiment = line[0..items_count div 2 - 1]
            second_compartiment = line[items_count div 2..items_count - 1]
            shared_item = first_compartiment.filterIt(
                    second_compartiment.contains(it))[0]
        if shared_item.isUpperAscii():
            inc total_priority, ord(shared_item) - ord('A') + 27
        else:
            inc total_priority, ord(shared_item) - ord('a') + 1

    echo "The answer for the first part is: ", total_priority

proc solve_second_part() =
    let file = open("inputs/input3.txt")
    defer: file.close()

    var
        line: string
        elves_group: seq[string]
        total_priority: int

    while file.read_line(line):
        if elves_group.len() != 3:
            elves_group.add(line)
            continue
        echo elves_group
        let
            first_elf = elves_group[0]
            second_elf = elves_group[1]
            third_elf = elves_group[2]

        let group_badge = first_elf.filterIt(second_elf.contains(it) and
                third_elf.contains(it))

        if group_badge.len() == 0:
            elves_group.delete(0..2)
            elves_group.add(line)
            echo elves_group
            continue

        if group_badge[0].isUpperAscii():
            inc total_priority, ord(group_badge[0]) - ord('A') + 27
        else:
            inc total_priority, ord(group_badge[0]) - ord('a') + 1

        echo "a"
        elves_group.delete(0..2)
        elves_group.add(line)
        echo elves_group

    let
        first_elf = elves_group[0]
        second_elf = elves_group[1]
        third_elf = elves_group[2]

    let group_badge = first_elf.filterIt(second_elf.contains(it) and
            third_elf.contains(it))

    if group_badge[0].isUpperAscii():
        inc total_priority, ord(group_badge[0]) - ord('A') + 27
    else:
        inc total_priority, ord(group_badge[0]) - ord('a') + 1

    echo "The answer for the first part is: ", total_priority


solve_first_part()
solve_second_part()

