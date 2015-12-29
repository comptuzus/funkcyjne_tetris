open Sdlevent
open Sdlkey
open Gametimer
type gameState = { mutable position_x: int; mutable position_y: int }
    
let rec loop game_state =
    match wait_event () with
    | KEYDOWN { keysym = KEY_ESCAPE } ->
        print_endline "You pressed escape! The fun is over now."
    | USER 0 ->
        print_endline "tick!";
        loop game_state
    | event ->
        print_endline (string_of_event event);
        loop game_state
    
let init () =
    let game_state = { position_x = 200; position_y = 0 } in
    let timer_flag = { running = true } in
    let timer_thread = create_game_timer (timer_flag) in
    
    loop game_state;
    timer_flag.running <- false;
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