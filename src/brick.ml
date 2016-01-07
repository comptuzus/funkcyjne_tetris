open Types

let box_size brick =
    Array.length brick.box
    
let rotate brick =
    let size        = box_size brick in
    let new_box     = Array.make_matrix size size Empty in
    
    Utils.iterate brick.box (fun x y field ->
        let (x, y) = (size - 1 - y, x) in
        new_box.(x).(y) <- field);
    brick.box <- new_box
    
let rotate_n_times brick n =
    let rec aux i brick =
        if (i = 0)
        then brick
        else (
            rotate brick;
            aux (i - 1) brick
        )
    in aux n brick
    
let create number =
    let color   =   Random.int 4 in
    let rotation=   Random.int 4 in
    let size    =   match number with
                    | 0 -> 2
                    | 1 -> 4
                    | _ -> 3
                    in
                    
    let brick   = {
        position    = { x = 3; y = 0 };
        box         = Array.make_matrix size size Empty
    } in
    
    (match number with
    | 0 ->
        brick.box.(0).(0) <- Square color;
        brick.box.(1).(0) <- Square color;
        brick.box.(0).(1) <- Square color;
        brick.box.(1).(1) <- Square color;
    | 1 ->
        brick.box.(0).(0) <- Square color;
        brick.box.(1).(0) <- Square color;
        brick.box.(2).(0) <- Square color;
        brick.box.(3).(0) <- Square color;
    | 2 ->
        brick.box.(0).(0) <- Square color;
        brick.box.(0).(1) <- Square color;
        brick.box.(1).(1) <- Square color;
        brick.box.(0).(2) <- Square color;
    | 3 ->
        brick.box.(0).(0) <- Square color;
        brick.box.(1).(0) <- Square color;
        brick.box.(1).(1) <- Square color;
        brick.box.(2).(1) <- Square color;
    | 4 ->
        brick.box.(1).(0) <- Square color;
        brick.box.(2).(0) <- Square color;
        brick.box.(0).(1) <- Square color;
        brick.box.(1).(1) <- Square color;
    );
    rotate_n_times brick rotation
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    (*
        BRICK TYPES:
        0:
            xx
            xx
            
        1:
            xxxx
        
        2:
            x
            xx
            x
        
        3:
            xx
             xx
        
        4:
             xx
            xx
    *)