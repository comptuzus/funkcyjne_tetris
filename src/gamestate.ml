open Types
open Printf

let write_highscore score = 
    let oc = open_out "highscore" in
    fprintf oc "%d\n" score;
    close_out oc
    
let read_highscore () =
    let ic = open_in "highscore" in
    let score = int_of_string (input_line ic) in
    close_in ic;
    score

let new_game () = {
    state       = Running;
    board       = Array.make_matrix 18 10 Empty;
    board_size  = { x = 10; y = 18 };
    brick       = Brick.create_random_brick ();
    next_brick  = Brick.create_random_brick ();
    points      = 0;
    highscore   = read_highscore ();
    brick_n     = 1;
}