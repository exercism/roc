module [sublist]

sublist : List a, List a -> [Equal, Sublist, Superlist, Unequal] where a implements Eq
sublist = \list1, list2 ->
    crash "Please implement the 'sublist' function"
