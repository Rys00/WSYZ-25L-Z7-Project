import requests

api_key = "AIzaSyB7RFGSyRXpBM-9Mj1NRZdVZolPxSAcVJs"
p = [ "Błonie", "Książenice", "Góra Kalwaria", "Otwock", "Wołomin", "Legionowo"]
m = ["Pruszków", "Piaseczno", "Zielonka"]
s = [
    "Marszałkowska 136, Warszawa",
    "Twarda 44, Warszawa",
    "Waliców 10, Warszawa",
    "Szpitalna 1, Warszawa",
    "Targowa 56, Warszawa",
    "Ursynowska 40, Warszawa",
    "Grochowska 263, Warszawa",
    "Żuławskiego 2, Warszawa",
    "Ostródzka 119, Warszawa",
    "Zgrupowania \"Żmija\" 19A, Warszawa"
]

def calc_distance(o, d, n1: str, n2: str):
    print(f"\nparam odleglosc_{n1.lower()}{n2.lower()}:", " ".join([f"{n2.upper()}{i+1}" for i in range(len(d))]), ":=")
    for i, origin in enumerate(o):
        print(f"  {n1.upper()}{i+1}", end="")
        for j, destination in enumerate(d):
            r = requests.get(f"https://maps.googleapis.com/maps/api/distancematrix/json?destinations={destination}, Polska&origins={origin}, Polska&units=0&key={api_key}")
            v = r.json()["rows"][0]["elements"][0]["distance"]["value"] / 1000
            print(f" {v}", end="")
        if i + 1 < len(o): print()
        else: print(";")

calc_distance(p, m, "p", "m")
# calc_distance(m, s, "m", "s")