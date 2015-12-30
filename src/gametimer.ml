type timerData = {
    mutable running: bool;
    mutable speed: float
}

let rec timer_loop (timer_data, callback) =
    if (timer_data.running) then
    ( 
        Thread.delay timer_data.speed;
        callback ();
        timer_loop (timer_data, callback)
    )
    else
        Thread.exit

let create_game_timer callback timer_data =
    Thread.create timer_loop (timer_data, callback)