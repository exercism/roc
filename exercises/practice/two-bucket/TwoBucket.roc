module [measure]

measure :
    { bucketOne : U64, bucketTwo : U64, goal : U64, startBucket : [One, Two] }
    ->
    Result { moves : U64, goalBucket : [One, Two], otherBucket : U64 } _
measure = \{ bucketOne, bucketTwo, goal, startBucket } ->
    crash "Please implement the 'measure' function"
