type timerFlag = { mutable running: bool }

let rec timer_loop (flag, callback) =
    if (flag.running) then
    ( 
        Thread.delay 0.5;
        callback ();
        timer_loop (flag, callback)
    )
    else
        Thread.exit

let create_game_timer timer_flag =
    let timer_cb () = Sdlevent.add [USER 0] in
    let timer_thread = Thread.create timer_loop (timer_flag, timer_cb) in
    
    timer_thread