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
><kbd>←</kbd> przesunięcie klocka o jedno pole w lewo<br>
><kbd>→</kbd> przesunięcie klocka o jedno pole w prawo<br>
><kbd>↓</kbd> 	przesunięcie klocka o jedno pole w dół (gdy przycisk jest wciśnięty klocek spada szybciej)<br>
><kbd>↑</kbd> obrót klocka o 90 stopni w prawo<br>
>
><kbd>M</kbd> wyłączenie/włączenie dźwięku w grze<br>
><kbd>R</kbd> reset gry<br>
><kbd>ESC</kbd> wyjście z gry<br>