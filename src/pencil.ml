open Gamestate

type pencilInfo = {
    screen: Sdlvideo.surface;
    square: Sdlvideo.surface;
    (*font:   Sdlttf.font*)
}

let draw game_state pencil_info =
    let position_of_image = Sdlvideo.rect game_state.position.x game_state.position.y 30 30 in
    
    Sdlvideo.fill_rect pencil_info.screen (Sdlvideo.map_RGB pencil_info.screen Sdlvideo.white);
    Sdlvideo.blit_surface ~dst_rect:position_of_image ~src:pencil_info.square ~dst:pencil_info.screen ();
    Sdlvideo.flip pencil_info.screen