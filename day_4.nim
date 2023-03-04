import strutils

proc solve*() =
    let file = open("inputs/input4.txt")
    defer: file.close()

    var
        line: string
        total_overlaped_ranges_first_part: int = 0
        total_overlaped_ranges_second_part: int = 0

    while file.read_line(line):
        let ranges = line.split(",")
        let
            first_elf_range = ranges[0].split("-")
            second_elf_range = ranges[1].split("-")
            starting_index_first_elf = parseInt(first_elf_range[0])
            last_index_first_elf = parseInt(first_elf_range[1])
            starting_index_second_elf = parseInt(second_elf_range[0])
            last_index_second_elf = parseInt(second_elf_range[1])

        if (starting_index_first_elf <= starting_index_second_elf and
                last_index_first_elf >= last_index_second_elf) or (
                starting_index_second_elf <= starting_index_first_elf and
                last_index_second_elf >= last_index_first_elf):
            inc total_overlaped_ranges_first_part

        if last_index_first_elf >= starting_index_second_elf and
                starting_index_first_elf <= last_index_second_elf:
            inc total_overlaped_ranges_second_part

    echo "The answer for the first part is: ", total_overlaped_ranges_first_part
    echo "The answer for the second part is: ", total_overlaped_ranges_second_part

if isMainModule:
    solve()

