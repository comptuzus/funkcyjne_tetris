open Gamestate

type pencilData = {
    screen:     Sdlvideo.surface;
    squares:    Sdlvideo.surface array;
    board:      Sdlvideo.surface;
    (*font:   Sdlttf.font*)
}

let draw game_state pencil_data =
    let board_offset = { x = 50; y = 35; } in
    (* WTF: PO USUNIĘCIU NASTĘPNEJ LINII PROGRAM SIĘ NIE KOMPILUJE XDDDD *)
    let position_of_image = Sdlvideo.rect (board_offset.x + game_state.position.x) (board_offset.y + game_state.position.y) 30 30 in
    let position_of_board = Sdlvideo.rect (board_offset.x - 1) (board_offset.y - 1) 302 542 in
    let calc_rect x y =
        Sdlvideo.rect (x * 30 + board_offset.x) (y * 30 + board_offset.y) 30 30 in
    
    Sdlvideo.fill_rect pencil_data.screen (Sdlvideo.map_RGB pencil_data.screen (54, 54, 54));
    
    (* BOARD DRAWING *)
    Sdlvideo.blit_surface ~dst_rect:position_of_board ~src:pencil_data.board ~dst:pencil_data.screen ();
    Array.iteri (fun x column -> 
                    Array.iteri (fun y field ->
                        match field with
                        | Empty         ->  ()
                        | Square color  ->  Sdlvideo.blit_surface ~dst_rect:(calc_rect x y) ~src:pencil_data.squares.(color) ~dst:pencil_data.screen ()
                    ) column
    ) game_state.board; 
    
    Sdlvideo.flip pencil_data.screen