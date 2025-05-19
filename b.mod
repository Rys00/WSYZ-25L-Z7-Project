set MAGAZYNY;
set SKLEPY;
set PRODUKTY;

param cena_za_1km_1ton >= 0;

param pojemnosc_magazyn_max{MAGAZYNY} >= 0;
param pojemnosc_sklep_max{SKLEPY} >= 0;

param odleglosc_ms{MAGAZYNY, SKLEPY} >= 0;

param zapotrzebowanie_sklepy{1..52, PRODUKTY, SKLEPY} >= 0;

var transport_ms{1..52, PRODUKTY, MAGAZYNY, SKLEPY} >= 0;

minimize koszt:
  sum{w in 1..52, p in PRODUKTY, m in MAGAZYNY, s in SKLEPY} transport_ms[w, p, m, s] * odleglosc_ms[m, s] * cena_za_1km_1ton;

subject to transport_ms_min{w in 1..52, p in PRODUKTY, s in SKLEPY}:
  sum{i in 1..w, m in MAGAZYNY} transport_ms[i, p, m, s] >= 0.1 * zapotrzebowanie_sklepy[w, p, s] + sum{i in 1..w} zapotrzebowanie_sklepy[i, p, s];
subject to magazyn_sklep{w in 1..52, s in SKLEPY}:
  sum{i in 1..w, p in PRODUKTY} ((sum{m in MAGAZYNY} transport_ms[i, p, m, s]) - zapotrzebowanie_sklepy[i, p, s]) <= pojemnosc_sklep_max[s];
subject to magazyn_limit {m in MAGAZYNY}:
  sum{i in 1..52, p in PRODUKTY, s in SKLEPY} transport_ms[i, p, m, s] <= pojemnosc_magazyn_max[m];
;

# komenda
# reset; model "b.mod"; data "b.dat"; option solver cplex; solve; display koszt;
# stan magazynów dla poszczególnych produktów
# display{w in 1..52, p in PRODUKTY, s in SKLEPY} sum{i in 1..w} ((sum{m in MAGAZYNY} transport_ms[i, p, m, s]) - zapotrzebowanie_sklepy[i, p, s]);
# stan magazynów dla poszczególnych łącznie
# display{w in 1..52, s in SKLEPY} sum{i in 1..w, p in PRODUKTY} ((sum{m in MAGAZYNY} transport_ms[i, p, m, s]) - zapotrzebowanie_sklepy[i, p, s]);
# magazyny zapotrzebowanie
# display{m in MAGAZYNY, p in PRODUKTY} sum{i in 1..52, s in SKLEPY} transport_ms[i, p, m, s];