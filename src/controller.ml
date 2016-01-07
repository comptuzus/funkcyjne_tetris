open Types

let collision game =
    let not_ret = { col_res = true } in

    Utils.iterate game.brick.box (
        fun x y field ->
            match field with
            | Empty     ->  ()
            | Square _  ->
                let x = x + game.brick.position.x in
                let y = y + game.brick.position.y in

                not_ret.col_res <- not_ret.col_res &&
                    x >= 0 && x < game.board_size.x &&
                    y >= 0 && y < game.board_size.y &&
                    game.board.(x).(y) = Empty
    );
    not not_ret.col_res
    
let remove_line game n =
    let rec aux i =
        if i > 1
        then
    Utils.iterate game.board (
        fun x y field ->
            if y = 0
            then game.board.(x).(y) <- Empty
            else    if y < n
                    then game.board.(x).(y + 1) <- field
    )
    
let remove_lines game =
    let lines = Array.make game.board_size.y 0 in
    
    Utils.iterate game.board (
        fun x y field ->
            match field with
            | Empty     ->  ()
            | Square _  ->  lines.(y) <- lines.(y) + 1
    );
    Array.iteri (
        fun y counter ->
            if counter = game.board_size.y
            then remove_line game y
    ) lines
    
let fall game =
    game.brick.position.y <- game.brick.position.y + 1;
    if collision game
    then (
        game.brick.position.y <- game.brick.position.y - 1;
        Utils.iterate game.brick.box (
            fun x y field ->
                match field with
                | Empty         -> ()
                | Square color  ->
                    let x = x + game.brick.position.x in
                    let y = y + game.brick.position.y in
                    game.board.(x).(y) <- Square color
        );
        remove_lines game;        
        game.brick <- Brick.create (Random.int 5);
        if collision game
        then    game.state <- End
    )


let handle game_data event =
    let game   = game_data.game_state in
    let timer   = game_data.timer_data in
    let pencil  = game_data.pencil_data in

    match event with
    | Sdlevent.USER 0 ->
        fall game;
        Pencil.draw game pencil
        
    | KEYDOWN { keysym = KEY_DOWN } ->
        fall game;
        Pencil.draw game pencil
    | KEYDOWN { keysym = KEY_LEFT } ->
        game.brick.position.x <- game.brick.position.x - 1;
        if collision game
        then    game.brick.position.x <- game.brick.position.x + 1
        else    Pencil.draw game pencil
    | KEYDOWN { keysym = KEY_RIGHT } ->
        game.brick.position.x <- game.brick.position.x + 1;
        if collision game
        then    game.brick.position.x <- game.brick.position.x - 1
        else    Pencil.draw game pencil
    | KEYDOWN { keysym = KEY_UP } ->
        Brick.rotate game.brick;
        if collision game
        then    ignore (Brick.rotate_n_times game.brick 3);
        Pencil.draw game pencil
    | event ->
        print_endline (Sdlevent.string_of_event event)