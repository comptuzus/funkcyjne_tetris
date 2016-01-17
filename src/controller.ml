open Types

let game_end (game:gameState) =
    game.state <- End;
    if      (game.points > game.highscore)
    then    Gamestate.write_highscore game.points

let collision game =
    let not_ret = { col_res = true } in

    Utils.iterate game.brick.box (
        fun y x field ->
            match field with
            | Empty     ->  ()
            | Square _  ->
                let x = x + game.brick.position.x in
                let y = y + game.brick.position.y in

                not_ret.col_res <- not_ret.col_res &&
                    x >= 0 && x < game.board_size.x &&
                    y >= 0 && y < game.board_size.y &&
                    game.board.(y).(x) = Empty
    );
    not not_ret.col_res

let remove_line (game: gameState) n =
    let rec aux i =
        if i > 0
        then (
            game.board.(i) <- Array.copy game.board.(i - 1);
            aux (i - 1)
        )
    in

    aux n;
    Array.fill game.board.(0) 0 game.board_size.x Empty

let remove_lines game =
    let a = max game.brick.position.y 0 in
    let b = min (game.brick.position.y + (Array.length game.brick.box)) game.board_size.y in
    let counter = { lines_removed = 0 } in

    Utils.iteri_ab game.board a b (
        fun y row ->
            if  Utils.every row (
                    fun field ->
                        not (field = Empty)
                )
            then (
                remove_line game y;
                counter.lines_removed <- counter.lines_removed + 1
            )
    );
    counter

let copy_brick_to_board (game: gameState) =    
    Utils.iterate game.brick.box (
        fun y x field ->
            match field with
            | Empty         -> ()
            | Square color  ->
                let x = x + game.brick.position.x in
                let y = y + game.brick.position.y in
                game.board.(y).(x) <- Square color;
    )

let fall (game: gameState) (timer: timerData) =
    game.brick.position.y <- game.brick.position.y + 1;
    if collision game
    then (
        game.brick.position.y <- game.brick.position.y - 1;
        copy_brick_to_board game;

        let lines_removed = remove_lines game in
        game.points <- game.points + lines_removed.lines_removed;
        timer.speed <- timer.speed *. (Utils.pow 0.98  lines_removed.lines_removed);

        game.brick <- game.next_brick;
        game.next_brick <- Brick.create_random_brick ();
        game.brick_n <- game.brick_n + 1;
        print_endline (string_of_int game.points ^ " - " ^ (string_of_float timer.speed) ^ " - " ^ (string_of_int game.brick_n));        
        if      collision game
        then    game_end game
    )


let handle game_data event =
    let game   = game_data.game_state in
    let timer   = game_data.timer_data in
    let pencil  = game_data.pencil_data in

    match event with
    | Sdlevent.USER 0 ->
        fall game timer;
        Pencil.draw game pencil

    | KEYDOWN { keysym = KEY_DOWN } ->
        timer.speed <- timer.speed *. 0.1;
        Sdlevent.add [USER 0]
    | KEYUP { keysym = KEY_DOWN } ->
        timer.speed <- timer.speed *. 10.0;
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
    | KEYDOWN { keysym = KEY_SPACE } ->
        game.state <- End
    | event ->
        ()