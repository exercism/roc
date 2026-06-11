AffineCipher :: {}.{
    alphabet_size : U64
    alphabet_size = 26

    group_length : U64
    group_length = 5

    new : { a : U64, b : U64 } -> Try(AffineCipher, [InvalidKey])
    new = |key| {
        crash "Please implement the 'new' method"
    }

    encode : Str, AffineCipher -> Try(Str, [BadUtf8(_)])
    encode = |affine_cipher, phrase| {
        crash "Please implement the 'encode' method"
    }

    decode : Str, AffineCipher -> Try(Str, [BadUtf8(_)])
    decode = |affine_cipher, phrase| {
        crash "Please implement the 'decode' method"
    }
}

# The following functions should soon be available in Roc's builtins
map_try = |iter, func| {
    var $state = []
    for item in iter {
        $state = $state.append(func(item)?)
    }
    Ok($state)
}

join_map = |iter, func| {
    var $state = []
    for item in iter {
        for subitem in func(item) {
            $state = $state.append(subitem)
        }
    }
    $state
}

join = |iter| {
    var $state = []
    for sublist in iter {
        for item in sublist {
            $state = $state.append(item)
        }
    }
    $state
}

chunks_of = |iter, size| {
    var $state = []
    var $chunk = []
    for item in iter {
        $chunk = $chunk.append(item)
        if $chunk.len() == size {
            $state = $state.append($chunk)
            $chunk = []
        }
    }
    if $chunk.len() > 0 {
        $state = $state.append($chunk)
    }
    $state
}

intersperse = |list, sep| {
    match list {
        [] => []
        [_] => list
        [first, .. as rest] => [first, sep].concat(intersperse(rest, sep))
    }
}
