import strutils

type
    AdversaryChoice {.pure.} = enum
        Rock = "A",
        Paper = "B",
        Scissors = "C"

    PlayerChoice {.pure.} = enum
        Rock = "X",
        Paper = "Y",
        Scissors = "Z"

    RoundResult {.pure.} = enum
        Lost = "X",
        Won = "Z",
        Draw = "Y"

proc decide_round_result(adversary_election: AdversaryChoice,
        player_election: PlayerChoice): RoundResult =
    if (adversary_election == AdversaryChoice.Rock and player_election ==
            PlayerChoice.Scissors) or (adversary_election ==
            AdversaryChoice.Paper and player_election == PlayerChoice.Rock) or (
            adversary_election == AdversaryChoice.Scissors and
            player_election == PlayerChoice.Paper):
        return RoundResult.Lost
    elif (adversary_election == AdversaryChoice.Rock and player_election ==
            PlayerChoice.Paper) or (adversary_election ==
            AdversaryChoice.Paper and player_election ==
            PlayerChoice.Scissors) or (adversary_election ==
            AdversaryChoice.Scissors and player_election == PlayerChoice.Rock):
        return RoundResult.Won
    else:
        return RoundResult.Draw

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

proc solve_first_part() =
    let file = open("inputs/input2.txt")
    defer: file.close()

    var line: string
    var total_points: int = 0
    while file.read_line(line):
        let round_elections = split(line)
        let adversary_election = parseEnum[AdversaryChoice](round_elections[0])
        let player_election = parseEnum[PlayerChoice](round_elections[1])
        let round_result: RoundResult = decide_round_result(adversary_election, player_election)
        case round_result:
            of RoundResult.Won:
                total_points += 6
            of RoundResult.Draw:
                total_points += 3
            of RoundResult.Lost:
                discard
        case player_election:
            of PlayerChoice.Rock:
                total_points += 1
            of PlayerChoice.Paper:
                total_points += 2
            of PlayerChoice.Scissors:
                total_points += 3

    echo "The answer for the first part is: ", total_points

proc solve_second_part() =
    let file = open("inputs/input2.txt")
    defer: file.close()

    var line: string
    var total_points: int = 0
    while file.read_line(line):
        let round_elections = split(line)
        let adversary_election = parseEnum[AdversaryChoice](round_elections[0])
        let expected_round_result = parseEnum[RoundResult](round_elections[1])
        let player_election: PlayerChoice = decide_option(adversary_election, expected_round_result)
        case expected_round_result:
            of RoundResult.Won:
                total_points += 6
            of RoundResult.Draw:
                total_points += 3
            of RoundResult.Lost:
                discard
        case player_election:
            of PlayerChoice.Rock:
                total_points += 1
            of PlayerChoice.Paper:
                total_points += 2
            of PlayerChoice.Scissors:
                total_points += 3

    echo "The answer for the first part is: ", total_points

solve_first_part()
solve_second_part()
