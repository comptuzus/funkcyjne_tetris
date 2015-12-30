type point = {
    mutable x: int;
    mutable y: int
}

type field =
    | Empty
    | Square of int

type state =
    | Running
    | Paused
    | End

type gameState = {
    mutable state:      state;
    mutable position:   point;
    mutable board:      field array array;
    board_size:         point;    
}

let new_game () = {
    state       = Running;
    position    = { x = 200; y = 0 };
    board       = Array.make_matrix 10 18 Empty;
    board_size  = { x = 10; y = 18 }
}