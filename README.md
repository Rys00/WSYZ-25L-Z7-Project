# Raport z rozwiązaniami do cz. II projektu z przedmiotu WSYZ

Wykonali: Martyna Orzechowska 331417, Mateusz Ogniewski 331413, Mateusz Wawrzyniak 3314xx

## Analiza problemu


## Przykładowe dane

## Opracowane modele

## Otrzymane wyniki


## Korzystanie z narzędzia ampl

```sh
# podpunkt b i c:
reset; model "b.mod"; data "b.dat"; option solver cplex; solve; display koszt;
# wyniki do b:
display transport_ms;
# wyniki do c:
display{w in 1..52, p in PRODUKTY, s in SKLEPY} sum{i in 1..w} ((sum{m in MAGAZYNY} transport_ms[i, p, m, s]) - zapotrzebowanie_sklepy[i, p, s]);
# dane do a:
display{m in MAGAZYNY, p in PRODUKTY} sum{i in 1..52, s in SKLEPY} transport_ms[i, p, m, s];
# podpunkt a:
reset; model "a.mod"; data "a.dat"; option solver cplex; solve; display koszt;
# wyniki do a:
display transport_pm;
```