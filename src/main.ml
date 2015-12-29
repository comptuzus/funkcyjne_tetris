type gameInfo = {
    mutable game_state:     Gamestate.gameState;
    mutable timer_info:     Gametimer.timerInfo;
    mutable pencil_info:    Pencil.pencilInfo
}
    
let rec loop game_info =
    match Sdlevent.wait_event () with
    | KEYDOWN { keysym = KEY_ESCAPE } ->
        print_endline "You pressed escape! The fun is over now."
    | USER 0 ->
        game_info.game_state.position.y <- game_info.game_state.position.y + 30;
        Pencil.draw game_info.game_state game_info.pencil_info;
        loop game_info
    | event ->
        Controller.handle game_info.game_state event;
        loop game_info
    
let init () =
    let game_info = {
        game_state  = Gamestate.new_game ();
        timer_info  = {
            running = true;
            speed   = 1.0
        };
        pencil_info = {
            screen  = Sdlvideo.set_video_mode 800 600 [`DOUBLEBUF];
            square  = Sdlloader.load_image "assets/square.png";
            (*font    = Sdlttf.open_font font_filename 24*)
        }
    } in
    let timer_cb () = Sdlevent.add [USER 0] in
    let timer_thread = Gametimer.create_game_timer timer_cb game_info.timer_info in
    
    loop game_info;
    game_info.timer_info.running <- false;
    Thread.join timer_thread    

let main () =
    Sdl.init [`VIDEO; `AUDIO];
    at_exit Sdl.quit;
    Sdlttf.init ();
    at_exit Sdlttf.quit;
    Sdlmixer.open_audio ();
    at_exit Sdlmixer.close_audio;
    init ()

let _ = main ()