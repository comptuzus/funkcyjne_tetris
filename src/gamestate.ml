type point = {
    mutable x: int;
    mutable y: int
}

type state =
    | Running
    | Paused
    | End

type gameState = {
    mutable state:      state;
    mutable position:   point;
    mutable speed:      float
}

let new_game () = {
    state       = Running;
    position    = { x = 200; y = 0 };
    speed       = 1.0
}