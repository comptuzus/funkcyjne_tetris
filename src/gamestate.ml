open Types

let new_game () = {
    state       = Running;
    board       = Array.make_matrix 18 10 Empty;
    board_size  = { x = 10; y = 18 };
    brick       = Brick.create_random_brick ();
    points      = 0;
    brick_n     = 1;
}