import sequtils

proc solve*() =
    let file = open("inputs/input6.txt")
    defer: file.close()

    var
        packet_marker_index: int = 0
        message_marker_index: int = 0
        packet_marker_candidate: seq[char]
        message_marker_candidate: seq[char]
        packet_marker_found = false
        message_marker_found = false

    let signal = readLine(file)
    for c in signal:
        if packet_marker_candidate.len == 4 and not packet_marker_found:
            let is_correct_marker = deduplicate(packet_marker_candidate).len == 4
            if is_correct_marker:
                packet_marker_found = true
            else:
                packet_marker_candidate.delete(0)
                inc packet_marker_index

        if message_marker_candidate.len == 14 and not message_marker_found:
            let is_correct_marker = deduplicate(message_marker_candidate).len == 14
            if is_correct_marker:
                message_marker_found = true
            else:
                message_marker_candidate.delete(0)
                inc message_marker_index

        if message_marker_found and packet_marker_found:
            echo "The answer for the first part is: ", packet_marker_index + 4
            echo "The answer for the second part is: ", message_marker_index + 14
            return

        packet_marker_candidate.add(c)
        message_marker_candidate.add(c)

if isMainModule:
    solve()
