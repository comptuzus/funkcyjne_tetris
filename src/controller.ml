type gameInfo = {
    mutable game_state:     Gamestate.gameState;
    mutable timer_info:     Gametimer.timerInfo;
    mutable pencil_info:    Pencil.pencilInfo
}

let handle game_info event =
    let game   = game_info.game_state in
    let timer   = game_info.timer_info in
    let pencil  = game_info.pencil_info in
    
    match event with
    | Sdlevent.USER 0 ->
        print_endline "tick!"
    | event ->
        print_endline (Sdlevent.string_of_event event)