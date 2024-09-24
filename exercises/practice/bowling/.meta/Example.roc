module [Game, create, roll, score]

Frame : [
    Ball1 U64, # unfinished frame
    Ball2 U64 U64,
    Spare U64 U64,
    Strike,
    SpareFill U64,
    StrikeFill1 U64, # unfinished frame
    StrikeFill2 U64 U64,
]

Game := { frames : List Frame }

create : { previousRolls ? List U64 } -> Result Game [MoreThan10Pins, GameOver]
create = \{ previousRolls ? [] } ->
    newGame = @Game { frames: [] }
    when previousRolls is
        [] -> Ok newGame
        rolls ->
            rolls
            |> List.walkUntil (Ok newGame) \state, pins ->
                when state is
                    Ok game ->
                        when game |> roll pins is
                            Ok updatedGame -> Continue (Ok updatedGame)
                            Err err -> Break (Err err)

                    Err _ -> crash "Impossible: state can never be an error since we never start or continue with an error"

checkMax10Pins : Frame, U64 -> Result {} [MoreThan10Pins, GameOver]
checkMax10Pins = \lastFrame, pins ->
    when lastFrame is
        Ball1 pins1 -> if pins1 + pins > 10 then Err MoreThan10Pins else Ok {}
        StrikeFill1 pins1 ->
            if pins > 10 || (pins1 < 10 && pins1 + pins > 10) then Err MoreThan10Pins else Ok {}

        Ball2 _ _ | Spare _ _ | Strike -> if pins > 10 then Err MoreThan10Pins else Ok {}
        SpareFill _ | StrikeFill2 _ _ -> Err GameOver

isOver : Game -> Bool
isOver = \@Game { frames } ->
    if List.len frames < 10 then
        Bool.false
    else
        when frames |> List.last is
            Ok (Ball1 _) | Ok (Spare _ _) | Ok Strike | Ok (StrikeFill1 _) -> Bool.false
            Ok (Ball2 _ _) | Ok (SpareFill _) | Ok (StrikeFill2 _ _) -> Bool.true
            Err ListWasEmpty -> crash "Impossible, we ensured that length is at least 10"

roll : Game, U64 -> Result Game [MoreThan10Pins, GameOver]
roll = \@Game { frames }, pins ->
    if @Game { frames } |> isOver then
        Err GameOver
        else

    lastFrame = frames |> List.last |> Result.withDefault (Ball2 0 0)
    checkMax10Pins? lastFrame pins
    updatedFrames =
        when lastFrame is
            Ball1 pins1 ->
                frames
                |> List.dropLast 1
                |> List.append
                    (
                        if pins1 + pins == 10 then
                            Spare pins1 pins
                        else
                            Ball2 pins1 pins
                    )

            StrikeFill1 pins1 ->
                frames |> List.dropLast 1 |> List.append (StrikeFill2 pins1 pins)

            Ball2 _ _ | Spare _ _ | Strike if List.len frames < 10 ->
                if pins == 10 then
                    frames |> List.append Strike
                else
                    frames |> List.append (Ball1 pins)

            Spare _ _ ->
                frames |> List.append (SpareFill pins)

            Strike ->
                frames |> List.append (StrikeFill1 pins)

            Ball2 _ _ | SpareFill _ | StrikeFill2 _ _ ->
                crash "Impossible, an unfinished game cannot have these in the last frame after the 10th frame"
    @Game { frames: updatedFrames } |> Ok

mapTriplets : List Frame, (Frame, Frame, Frame -> U64) -> List U64
mapTriplets = \list, scoreFunc ->
    getOr0 = \index -> list |> List.get index |> Result.withDefault (Ball2 0 0)
    List.range { start: At 0, end: Before (List.len list) }
    |> List.map \index ->
        scoreFunc (getOr0 index) (getOr0 (index + 1)) (getOr0 (index + 2))

firstPins : Frame -> U64
firstPins = \frame ->
    when frame is
        Ball1 pins | Ball2 pins _ | Spare pins _ | SpareFill pins | StrikeFill1 pins | StrikeFill2 pins _ -> pins
        Strike -> 10

totalPins : Frame -> U64
totalPins = \frame ->
    when frame is
        Ball2 pins1 pins2 | Spare pins1 pins2 | StrikeFill2 pins1 pins2 -> pins1 + pins2
        Ball1 pins | SpareFill pins | StrikeFill1 pins -> pins
        Strike -> 10

score : Game -> Result U64 [GameIsNotOver]
score = \@Game { frames } ->
    if @Game { frames } |> isOver then
        frames
        |> mapTriplets \frame1, frame2, frame3 ->
            when frame1 is
                Ball2 pins1 pins2 -> pins1 + pins2
                Spare pins1 pins2 -> pins1 + pins2 + firstPins frame2
                Strike ->
                    when frame2 is
                        Strike -> 10 + 10 + firstPins frame3
                        _ -> 10 + totalPins frame2

                SpareFill _ -> 0 # already counted in the Spare
                StrikeFill2 _ _ -> 0 # already counter in the Strike
                Ball1 _ | StrikeFill1 _ ->
                    crash "Impossible, unfinished frames should not exist in a finished game"
        |> List.sum
        |> Ok
    else
        Err GameIsNotOver
