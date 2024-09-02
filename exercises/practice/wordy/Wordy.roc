module [answer]

answer : Str -> Result I64 [UnknownOperation, SyntaxError]
answer = \question ->
    crash "Please implement the 'answer' function"
