import strutils

type
    AdversaryChoice {.pure.} = enum
        Rock = "A"
        Paper = "B"
        Scissors = "C"

    PlayerChoice {.pure.} = enum
        Rock = (1, "X")
        Paper = (2, "Y")
        Scissors = (3, "Z")

    RoundResult {.pure.} = enum
        Lost = (0, "X")
        Draw = (1, "Y")
        Won = (2, "Z")

proc calculate_points_by_round_result(adversary_election: AdversaryChoice,
        player_election: PlayerChoice): int =
    if (adversary_election == AdversaryChoice.Rock and player_election ==
            PlayerChoice.Paper) or (adversary_election ==
            AdversaryChoice.Paper and player_election ==
            PlayerChoice.Scissors) or (adversary_election ==
            AdversaryChoice.Scissors and player_election == PlayerChoice.Rock):
        return 6
    elif (adversary_election == AdversaryChoice.Rock and player_election ==
            PlayerChoice.Rock) or (adversary_election ==
            AdversaryChoice.Paper and player_election == PlayerChoice.Paper) or
            (adversary_election == AdversaryChoice.Scissors and
            player_election == PlayerChoice.Scissors):
        return 3
    else:
        return 0

proc decide_option(adversary_election: AdversaryChoice,
        expected_result: RoundResult): PlayerChoice =
    if (adversary_election == AdversaryChoice.Rock and expected_result ==
            RoundResult.Won) or (adversary_election ==
            AdversaryChoice.Scissors and expected_result == RoundResult.Lost) or
            (adversary_election == AdversaryChoice.Paper and expected_result ==
            RoundResult.Draw):
        return PlayerChoice.Paper
    elif (adversary_election == AdversaryChoice.Paper and expected_result ==
            RoundResult.Won) or (adversary_election ==
            AdversaryChoice.Scissors and expected_result == RoundResult.Draw) or
            (adversary_election == AdversaryChoice.Rock and expected_result ==
            RoundResult.Lost):
        return PlayerChoice.Scissors
    else:
        return PlayerChoice.Rock

proc solve*() =
    let file = open("inputs/input2.txt")
    defer: file.close()

    var line: string
    var
        total_point_first_part: int = 0
        total_point_second_part: int = 0

    while file.read_line(line):
        let round_elections = split(line)
        let adversary_election = parseEnum[AdversaryChoice](round_elections[0])
        let player_election = parseEnum[PlayerChoice](round_elections[1])
        let expected_round_result = parseEnum[RoundResult](round_elections[1])
        let player_election_for_expected_result: PlayerChoice = decide_option(
                adversary_election, expected_round_result)
        let points_for_round: int = calculate_points_by_round_result(
                adversary_election, player_election)
        inc total_point_first_part, points_for_round
        inc total_point_second_part, ord(expected_round_result) * 3
        inc total_point_first_part, ord(player_election)
        inc total_point_second_part, ord(player_election_for_expected_result)

    echo "The answer for the first part is: ", total_point_first_part
    echo "The answer for the second part is: ", total_point_second_part

if isMainModule:
    solve()
