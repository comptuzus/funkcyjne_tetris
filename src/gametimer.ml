type timerInfo = {
    mutable running: bool;
    mutable speed: float
}

let rec timer_loop (timer_info, callback) =
    if (timer_info.running) then
    ( 
        Thread.delay timer_info.speed;
        callback ();
        timer_loop (timer_info, callback)
    )
    else
        Thread.exit

let create_game_timer callback timer_info =
    Thread.create timer_loop (timer_info, callback)