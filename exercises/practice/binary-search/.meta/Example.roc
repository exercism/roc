module [find]

find : List U64, U64 -> Result U64 [ValueWasNotFound (List U64) U64]
find = |array, value|
    binary_search = |min_index, max_index|
        middle_index = (min_index + max_index) // 2
        middle_value = List.get(array, middle_index)?
        if middle_value == value then
            Ok(middle_index)
        else if min_index == max_index then
            Err(ValueWasNotFound(array, value))
        else if middle_value < value then
            Ok(binary_search((middle_index + 1), max_index)?)
        else
            Ok(binary_search(min_index, (middle_index - 1))?)

    binary_search(0, List.len(array))
    |> Result.on_err(|_| Err(ValueWasNotFound(array, value)))
