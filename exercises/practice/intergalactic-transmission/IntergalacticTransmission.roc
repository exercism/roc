IntergalacticTransmission :: {}.{
    transmit_sequence : List(U8) -> List(U8)
    transmit_sequence = |message| {
        crash "Please implement the 'transmit_sequence' function"
    }

    decode_message : List(U8) -> Try(List(U8), _)
    decode_message = |message| {
        crash "Please implement the 'decode_message' function"
    }
}
