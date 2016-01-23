# funkcyjne_tetris
Projekt końcowy z programowania funkcyjnego 2015/2016

### Kompilacja
```
sudo apt-get install ocaml-tools libsdl-ocaml-dev
make
```

### Uruchomienie
```
./tetris [--seed n] [--music src]
```

###Sterowanie
><kbd>←</kbd> przesunięcie klocka o jedno pole w lewo
>
><kbd>→</kbd> przesunięcie klocka o jedno pole w prawo
>
><kbd>↓</kbd> 	przesunięcie klocka o jedno pole w dół (gdy przycisk jest wciśnięty klocek spada szybciej)
>
><kbd>↑</kbd> obrót klocka o 90 stopni w prawo
>
><kbd>M</kbd> wyłączenie/włączenie dźwięku w grze
>
><kbd>R</kbd> reset gry
>
><kbd>ESC</kbd> wyjście z gry