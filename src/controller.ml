open Types

let handle game_data event =
    let game   = game_data.game_state in
    let timer   = game_data.timer_data in
    let pencil  = game_data.pencil_data in
    
    match event with
    | Sdlevent.USER 0 ->
        game.brick.position.y <- game.brick.position.y + 1;
        Pencil.draw game pencil
    | KEYDOWN { keysym = KEY_SPACE } ->
        Brick.rotate game.brick;
        Pencil.draw game pencil
    | event ->
        print_endline (Sdlevent.string_of_event event)