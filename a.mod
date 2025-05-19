set PRODUCENCI;
set MAGAZYNY;
set PRODUKTY;

param cena_za_1km_1ton >= 0;

param produkcja_max{PRODUCENCI, PRODUKTY} >= 0;
param pojemnosc_magazyn_max{MAGAZYNY} >= 0;

param odleglosc_pm{PRODUCENCI, MAGAZYNY} >= 0;

param zapotrzebowanie_magazyny{MAGAZYNY, PRODUKTY} >= 0;

var transport_pm{PRODUCENCI, PRODUKTY, MAGAZYNY} >= 0;

minimize koszt:
  sum{r in PRODUCENCI, p in PRODUKTY, m in MAGAZYNY} transport_pm[r, p, m] * odleglosc_pm[r, m] * cena_za_1km_1ton;

subject to transport_pm_min{m in MAGAZYNY, p in PRODUKTY}:
  sum{r in PRODUCENCI} transport_pm[r, p, m] >= zapotrzebowanie_magazyny[m, p];
subject to produkcja_limit {r in PRODUCENCI, p in PRODUKTY}:
  sum{m in MAGAZYNY} transport_pm[r, p, m] <= produkcja_max[r, p];
subject to magazyn_limit {m in MAGAZYNY}:
  sum{r in PRODUCENCI, p in PRODUKTY} transport_pm[r, p, m] <= pojemnosc_magazyn_max[m];
;

# komenda
# reset; model "a.mod"; data "a.dat"; option solver cplex; solve; display koszt;