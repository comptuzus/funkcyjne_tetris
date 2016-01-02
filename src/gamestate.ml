open Types

let new_game () = {
    state       = Running;
    board       = Array.make_matrix 10 18 Empty;
    board_size  = { x = 10; y = 18 };
    brick       = Brick.create (Random.int 5)
}