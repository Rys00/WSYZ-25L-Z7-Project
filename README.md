# Raport z rozwiązaniami do cz. II projektu z przedmiotu WSYZ

Wykonali: Martyna Orzechowska 331417, Mateusz Ogniewski 331413, Mateusz Wawrzyniak 331450

## Analiza problemu

Jako zadanie projektowe otrzymaliśmy  zadanie opracować modele dot. optymalizacji kosztów transportu produktów spożywczych od producentów do magazynów a następnie do sklepów. Powyższy problem zdecydowaliśmy się przedstawić jako dwa osobne zadania optymalizacyjne. Zgodnie z informacją otrzymaną w poleceniu magazyny określają zapotrzebowanie na podstawie wcześniejszych zapotrzebowań poszczególnych sklepów na określone produkty. Następnie na podstawie zapotrzebowania sieci sklepów z poszczególnych magazynów  przystępujemy do dalszej optymalizacji kosztów transportu od producentów do magazynów.

## Przykładowe dane

Opracowując przykładowe dane przyjęliśmy następujące założenia:

- suma zapotrzebowań sklepów na poszczególne produkty wynosi ok. 70%  możliwości produkcyjnych podanych w poleceniu;
- pojemność magazynów przysklepowych wynosi  średnio ok. 2,5 tygodniowej sumy zapotrzebowania na podane produkty;
- magazyn przysklepowy musi mieć min. 10% przewidywanego zapotrzebowania danego produkty na magazynie jako minimalne zapasy w sytuacji losowej
- w celu obliczenia odległości między sklepami skorzystaliśmy z API od Google Maps.

W opracowywaniu danych uwzględniliśmy założenia podane w poleceniu.

Przykładowe dane zostały zapisane w plikach .dat. Zapotrzebowanie magazynów na poszczególne produkty zostało otrzymane korzystając z opracowanego modelu b.

## Opracowane modele

Opracowaliśmy dwa modele - model opowiadający za optymalizację całkowitego kosztu transportu między magazynami a siecią sklepów (model b) oraz model odpowiadający za optymalizację całkowitego kosztu transportu miedzy producentami a magazynami (model a). Jako funkcje celu modelu b wybraliśmy całkowity koszt transportu, ponieważ chcemy uzyskać jak najmniejsze koszty dla sieci sklepów a nie pojedyńczych sklepów jako byty niezależne. Analogicznie postąpiliśmy dla modelu a uznając poszczególne magazyny jako byty powiązane finansowo będące siecią.

W sytuacji podania za dużego zapotrzebowania sklepów do możliwości podanych magazynów zakładając tylko jedno zaopatrzenie sieci magazynów przez producentów model nie będzie w stanie podać rozwiązania problemu.

## Otrzymane wyniki

Całkowity koszt transportu producenci - magazyny: 172 075
Całkowity koszt transportu magazyny - sklepy: 151 113

Szczegółowe wyniki znajdują się w katalogu results, są to:

- plan transportu warzyw do sklepów z poszczególnych magazynów w danych tygodniach;
- plan transportu warzyw do magazynów od poszczególnych producentów;
- zapotrzebowanie magazynów na poszczególne warzywa;
- plan przechowywania produktów w magazynach przysklepowych.

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