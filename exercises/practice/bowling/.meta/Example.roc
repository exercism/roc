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

create : { previous_rolls ? List U64 } -> Result Game [MoreThan10Pins, GameOver]
create = \{ previous_rolls ? [] } ->
    List.walkTry previous_rolls (@Game { frames: [] }) \game, pins ->
        roll game pins

check_max_10_pins : Frame, U64 -> Result {} [MoreThan10Pins, GameOver]
check_max_10_pins = \last_frame, pins ->
    when last_frame is
        Ball1 pins1 -> if pins1 + pins > 10 then Err MoreThan10Pins else Ok {}
        StrikeFill1 pins1 ->
            if pins > 10 || (pins1 < 10 && pins1 + pins > 10) then Err MoreThan10Pins else Ok {}

        Ball2 _ _ | Spare _ _ | Strike -> if pins > 10 then Err MoreThan10Pins else Ok {}
        SpareFill _ | StrikeFill2 _ _ -> Err GameOver

is_over : Game -> Bool
is_over = \@Game { frames } ->
    when frames is
        _ if List.len frames < 10 -> Bool.false
        [.., Ball1 _] | [.., Spare _ _] | [.., Strike] | [.., StrikeFill1 _] -> Bool.false
        [.., Ball2 _ _] | [.., SpareFill _] | [.., StrikeFill2 _ _] -> Bool.true
        _ -> Bool.false

roll : Game, U64 -> Result Game [MoreThan10Pins, GameOver]
roll = \@Game { frames }, pins ->
    if @Game { frames } |> is_over then
        Err GameOver
        else

    last_frame = frames |> List.last |> Result.withDefault (Ball2 0 0)
    check_max_10_pins? last_frame pins
    updated_frames =
        when last_frame is
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
    @Game { frames: updated_frames } |> Ok

map_triplets : List Frame, (Frame, Frame, Frame -> U64) -> List U64
map_triplets = \list, score_func ->
    get_or_0 = \index -> list |> List.get index |> Result.withDefault (Ball2 0 0)
    List.range { start: At 0, end: Before (List.len list) }
    |> List.map \index ->
        score_func (get_or_0 index) (get_or_0 (index + 1)) (get_or_0 (index + 2))

first_pins : Frame -> U64
first_pins = \frame ->
    when frame is
        Ball1 pins | Ball2 pins _ | Spare pins _ | SpareFill pins | StrikeFill1 pins | StrikeFill2 pins _ -> pins
        Strike -> 10

total_pins : Frame -> U64
total_pins = \frame ->
    when frame is
        Ball2 pins1 pins2 | Spare pins1 pins2 | StrikeFill2 pins1 pins2 -> pins1 + pins2
        Ball1 pins | SpareFill pins | StrikeFill1 pins -> pins
        Strike -> 10

score : Game -> Result U64 [GameIsNotOver]
score = \@Game { frames } ->
    if @Game { frames } |> is_over then
        frames
        |> map_triplets \frame1, frame2, frame3 ->
            when frame1 is
                Ball2 pins1 pins2 -> pins1 + pins2
                Spare pins1 pins2 -> pins1 + pins2 + first_pins frame2
                Strike ->
                    when frame2 is
                        Strike -> 10 + 10 + first_pins frame3
                        _ -> 10 + total_pins frame2

                SpareFill _ -> 0 # already counted in the Spare
                StrikeFill2 _ _ -> 0 # already counter in the Strike
                Ball1 _ | StrikeFill1 _ ->
                    crash "Impossible, unfinished frames should not exist in a finished game"
        |> List.sum
        |> Ok
    else
        Err GameIsNotOver