let iterate matrix f =
    Array.iteri (fun x column ->
        Array.iteri (fun y field -> f x y field) column
    ) matrix