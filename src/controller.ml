type gameData = {
    mutable game_state:     Gamestate.gameState;
    mutable timer_data:     Gametimer.timerData;
    mutable pencil_data:    Pencil.pencilData
}

let handle game_data event =
    let game   = game_data.game_state in
    let timer   = game_data.timer_data in
    let pencil  = game_data.pencil_data in
    
    match event with
    | Sdlevent.USER 0 ->
        print_endline "tick!"
    | event ->
        print_endline (Sdlevent.string_of_event event)