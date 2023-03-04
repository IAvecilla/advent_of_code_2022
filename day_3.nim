import sequtils
import strutils

proc solve*() =
    let file = open("inputs/input3.txt")
    defer: file.close()

    var
        line: string
        total_priority_first_part, total_priority_second_part: int
        elves_group: seq[string]

    while file.read_line(line):
        let
            items_count = line.len()
            first_compartiment = line[0..items_count div 2 - 1]
            second_compartiment = line[items_count div 2..items_count - 1]
            shared_item = first_compartiment.filterIt(
                    second_compartiment.contains(it))[0]
        if shared_item.isUpperAscii():
            inc total_priority_first_part, ord(shared_item) - ord('A') + 27
        else:
            inc total_priority_first_part, ord(shared_item) - ord('a') + 1

        elves_group.add(line)
        if elves_group.len() != 3:
            continue
        let
            first_elf = elves_group[0]
            second_elf = elves_group[1]
            third_elf = elves_group[2]

        let group_badge = first_elf.filterIt(second_elf.contains(it) and
                third_elf.contains(it))

        if group_badge.len() == 0:
            elves_group.delete(0..2)
            continue

        if group_badge[0].isUpperAscii():
            inc total_priority_second_part, ord(group_badge[0]) - ord('A') + 27
        else:
            inc total_priority_second_part, ord(group_badge[0]) - ord('a') + 1

        elves_group.delete(0..2)

    echo "The answer for the first part is: ", total_priority_first_part
    echo "The answer for the second part is: ", total_priority_second_part

if isMainModule:
    solve()

