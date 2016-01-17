open Types
(* Sdlevent i Sdlkey, żeby nie rzucał warningów przy kompilacji...*)
open Sdlevent
open Sdlkey

let reset (game: gameData) =
    game.game_state <- Gamestate.new_game ();
    game.timer_data.running <- true;
    game.timer_data.speed <- 1.0

let rec loop (game: gameData) =
    match Sdlevent.wait_event () with
    | QUIT ->
        ()
    | KEYDOWN { keysym = KEY_r } ->
        reset game;
        loop game
    | event ->
        (if not (game.game_state.state = End)
        then Controller.handle game event
        else Pencil.draw game.game_state game.pencil_data);
        loop game

let run () =
    let game = {
        game_state  = Gamestate.new_game ();
        timer_data  = {
            running = true;
            speed   = 1.0
        };
        pencil_data = {
            screen      = Sdlvideo.set_video_mode 800 600 [`DOUBLEBUF];
            squares     = Array.init 4 (fun i -> Sdlloader.load_image ("assets/square_" ^ (string_of_int i) ^ ".png"));
            board       = Sdlloader.load_image "assets/board.png";
            preview     = Sdlloader.load_image "assets/preview.png";
            llamacorn   = Sdlloader.load_image "assets/llamacorn.png";
            lyingllama  = Sdlloader.load_image "assets/lyingllama.png";
            black_surf  = Sdlloader.load_image "assets/black_surf.png";
            font_40     = Sdlttf.open_font "assets/8bitOperatorPlus8-Regular.ttf" 40;
            font_30     = Sdlttf.open_font "assets/8bitOperatorPlus8-Regular.ttf" 30
        }
    } in
    let timer_cb () = Sdlevent.add [USER 0] in
    let timer_thread = Gametimer.create_game_timer timer_cb game.timer_data in

    Sdlvideo.set_alpha game.pencil_data.black_surf 150;
    Pencil.draw game.game_state game.pencil_data;
    loop game;
    game.timer_data.running <- false;
    Thread.join timer_thread

let main () =
    Random.self_init ();
    Sdl.init [`VIDEO; `AUDIO];
    at_exit Sdl.quit;
    Sdlttf.init ();
    at_exit Sdlttf.quit;
    Sdlmixer.open_audio ();
    at_exit Sdlmixer.close_audio;
    Sdlwm.set_caption "Tetris" "Tetris";
    Sdlevent.disable_events (Sdlevent.make_mask [ACTIVE_EVENT; MOUSEMOTION_EVENT; MOUSEBUTTONDOWN_EVENT; MOUSEBUTTONUP_EVENT]);
    Sdlmouse.show_cursor false;
    run ()

let _ = main ()