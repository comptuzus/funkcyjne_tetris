open Sdlevent
open Sdlkey

type point = { mutable x: int; mutable y: int }
type gameState = {
    mutable position: point;
    mutable timer_info: Gametimer.timerInfo
}
    
let rec loop game_state =
    match wait_event () with
    | KEYDOWN { keysym = KEY_ESCAPE } ->
        print_endline "You pressed escape! The fun is over now."
    | KEYDOWN { keysym = KEY_LEFT } ->
        game_state.timer_info.speed <- game_state.timer_info.speed -. 0.1;
        loop game_state
    | KEYDOWN { keysym = KEY_RIGHT } ->
        game_state.timer_info.speed <- game_state.timer_info.speed +. 0.1;
        loop game_state
    | USER 0 ->
        print_endline "tick!";
        loop game_state
    | event ->
        print_endline (string_of_event event);
        loop game_state
    
let init () =
    let game_state = {
        position = { x = 200; y = 0 };
        timer_info = { running = true; speed = 1.0 }
    } in
    let timer_cb () = Sdlevent.add [USER 0] in
    let timer_thread = Gametimer.create_game_timer timer_cb game_state.timer_info in
    
    loop game_state;
    game_state.timer_info.running <- false;
    Thread.join timer_thread    

let main () =
    Sdl.init [`VIDEO; `AUDIO];
    ignore (Sdlvideo.set_video_mode 800 600 []);
    at_exit Sdl.quit;
    Sdlttf.init ();
    at_exit Sdlttf.quit;
    Sdlmixer.open_audio ();
    at_exit Sdlmixer.close_audio;
    init ()

let _ = main ()