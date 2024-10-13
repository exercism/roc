# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/ocr-numbers/canonical-data.json
# File last updated on 2024-10-13
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import OcrNumbers exposing [convert]

# Recognizes 0
expect
    grid =
        """
         _ 
        | |
        |_|
           
        """
    result = convert grid
    expected = Ok "0"
    result == expected

# Recognizes 1
expect
    grid =
        """
           
          |
          |
           
        """
    result = convert grid
    expected = Ok "1"
    result == expected

# Unreadable but correctly sized inputs return ?
expect
    grid =
        """
           
          _
          |
           
        """
    result = convert grid
    expected = Ok "?"
    result == expected

# Input with a number of lines that is not a multiple of four raises an error
expect
    grid =
        """
         _ 
        | |
           
        """
    result = convert grid
    result |> Result.isErr

# Input with a number of columns that is not a multiple of three raises an error
expect
    grid =
        """
            
           |
           |
            
        """
    result = convert grid
    result |> Result.isErr

# Recognizes 110101100
expect
    grid =
        """
               _     _        _  _ 
          |  || |  || |  |  || || |
          |  ||_|  ||_|  |  ||_||_|
                                   
        """
    result = convert grid
    expected = Ok "110101100"
    result == expected

# Garbled numbers in a string are replaced with ?
expect
    grid =
        """
               _     _           _ 
          |  || |  || |     || || |
          |  | _|  ||_|  |  ||_||_|
                                   
        """
    result = convert grid
    expected = Ok "11?10?1?0"
    result == expected

# Recognizes 2
expect
    grid =
        """
         _ 
         _|
        |_ 
           
        """
    result = convert grid
    expected = Ok "2"
    result == expected

# Recognizes 3
expect
    grid =
        """
         _ 
         _|
         _|
           
        """
    result = convert grid
    expected = Ok "3"
    result == expected

# Recognizes 4
expect
    grid =
        """
           
        |_|
          |
           
        """
    result = convert grid
    expected = Ok "4"
    result == expected

# Recognizes 5
expect
    grid =
        """
         _ 
        |_ 
         _|
           
        """
    result = convert grid
    expected = Ok "5"
    result == expected

# Recognizes 6
expect
    grid =
        """
         _ 
        |_ 
        |_|
           
        """
    result = convert grid
    expected = Ok "6"
    result == expected

# Recognizes 7
expect
    grid =
        """
         _ 
          |
          |
           
        """
    result = convert grid
    expected = Ok "7"
    result == expected

# Recognizes 8
expect
    grid =
        """
         _ 
        |_|
        |_|
           
        """
    result = convert grid
    expected = Ok "8"
    result == expected

# Recognizes 9
expect
    grid =
        """
         _ 
        |_|
         _|
           
        """
    result = convert grid
    expected = Ok "9"
    result == expected

# Recognizes string of decimal numbers
expect
    grid =
        """
            _  _     _  _  _  _  _  _ 
          | _| _||_||_ |_   ||_||_|| |
          ||_  _|  | _||_|  ||_| _||_|
                                      
        """
    result = convert grid
    expected = Ok "1234567890"
    result == expected

# Numbers separated by empty lines are recognized. Lines are joined by commas.
expect
    grid =
        """
            _  _ 
          | _| _|
          ||_  _|
                 
            _  _ 
        |_||_ |_ 
          | _||_|
                 
         _  _  _ 
          ||_||_|
          ||_| _|
                 
        """
    result = convert grid
    expected = Ok "123,456,789"
    result == expected

