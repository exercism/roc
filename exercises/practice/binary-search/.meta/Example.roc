module [find]

find : List U64, U64 -> Result U64 [ValueNotInArray]
find = \array, value ->
    binarySearch = \minIndex, maxIndex ->
        middleIndex = (minIndex + maxIndex) // 2
        middleValue = array |> List.get? middleIndex
        if middleValue == value then
            Ok middleIndex
        else if minIndex == maxIndex then
            Err ValueNotInArray
        else if middleValue < value then
            Ok (binarySearch? (middleIndex + 1) maxIndex)
        else
            Ok (binarySearch? minIndex (middleIndex - 1))

    binarySearch 0 (List.len array)
    |> Result.onErr \_ -> Err ValueNotInArray
