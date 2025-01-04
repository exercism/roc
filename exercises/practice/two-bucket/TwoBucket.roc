module [measure]

measure :
    { bucket_one : U64, bucket_two : U64, goal : U64, start_bucket : [One, Two] }
    ->
    Result { moves : U64, goal_bucket : [One, Two], other_bucket : U64 } _
measure = \{ bucket_one, bucket_two, goal, start_bucket } ->
    crash "Please implement the 'measure' function"