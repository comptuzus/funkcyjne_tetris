let iterate matrix f =
    Array.iteri (fun y row ->
        Array.iteri (fun x field -> f y x field) row
    ) matrix
    
let every array f =
    Array.fold_left (
        fun acc e ->
            acc && f e
    ) true array
    
let iteri_ab array a b f =
    let rec aux i =
        if i < b
        then (
            f i array.(i);
            aux (i + 1)
        )
    in aux a
    
let rec pow a = function
    | 0 -> 1.0
    | 1 -> a
    | n -> 
        let b = pow a (n / 2) in
        b *. b *. (if n mod 2 = 0 then 1.0 else a)