type point = {
    mutable x: int;
    mutable y: int
}

type field =
    | Empty
    | Square of int

type brick = {
    mutable position:   point;
    mutable box:        field array array;
}

type state =
    | Running
    | Paused
    | End

type gameState = {
    mutable state:          state;
    mutable board:          field array array;
    board_size:             point;
    mutable brick:          brick;
    mutable next_brick:     brick;
    mutable points:         int;
    mutable highscore:      int;
    mutable pressing_down:  bool;
}

type pencilData = {
    screen:     Sdlvideo.surface;
    squares:    Sdlvideo.surface array;
    board:      Sdlvideo.surface;
    preview:    Sdlvideo.surface;
    llamacorn:  Sdlvideo.surface;
    lyingllama: Sdlvideo.surface;
    black_surf: Sdlvideo.surface;
    font_40:    Sdlttf.font;
    font_30:    Sdlttf.font
}

type timerData = {
    mutable running: bool;
    mutable speed: float
}

type gameData = {
    mutable game_state:     gameState;
    mutable timer_data:     timerData;
    mutable pencil_data:    pencilData
}