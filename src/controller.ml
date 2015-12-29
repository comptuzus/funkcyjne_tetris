let handle game_state event =
    match event with
    | Sdlevent.USER 0 ->
        print_endline "tick!";
    | event ->
        print_endline (Sdlevent.string_of_event event)