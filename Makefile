RESULT     = tetris
SOURCES    = src/types.ml src/utils.ml src/brick.ml src/gamestate.ml src/gametimer.ml src/pencil.ml src/controller.ml src/main.ml
LIBS       = unix threads bigarray sdl sdlloader sdlttf sdlmixer
INCDIRS    = +sdl +threads

include OCamlMakefile
