RESULT     = tetris
SOURCES    = src/gametimer.ml src/main.ml
LIBS       = unix threads bigarray sdl sdlloader sdlttf sdlmixer
INCDIRS    = +sdl +threads

include OCamlMakefile
