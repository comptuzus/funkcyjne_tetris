open Types

let draw (game_state: gameState) (pencil_data: pencilData) =
    let board_offset = { x = 50; y = 35; } in
    let position_of_board = Sdlvideo.rect (board_offset.x - 1) (board_offset.y - 1) 302 542 in
    let brick = game_state.brick in
    let calc_rect x y =
        Sdlvideo.rect (x * 30 + board_offset.x) (y * 30 + board_offset.y) 30 30 in
    
    Sdlvideo.fill_rect pencil_data.screen (Sdlvideo.map_RGB pencil_data.screen (22, 25, 29));
    
    (* BOARD DRAWING *)
    Sdlvideo.blit_surface ~dst_rect:position_of_board ~src:pencil_data.board ~dst:pencil_data.screen ();
    Utils.iterate game_state.board (fun y x field ->
        match field with
        | Empty         ->  ()
        | Square color  ->  Sdlvideo.blit_surface ~dst_rect:(calc_rect x y) ~src:pencil_data.squares.(color) ~dst:pencil_data.screen ());
    
    (* BRICK DRAWING *)
    Utils.iterate game_state.brick.box (fun y x field ->
        match field with
        | Empty         ->  ()
        | Square color  ->  Sdlvideo.blit_surface ~dst_rect:(calc_rect (x + brick.position.x) (y + brick.position.y)) ~src:pencil_data.squares.(color) ~dst:pencil_data.screen ());
    
    Sdlvideo.flip pencil_data.screen