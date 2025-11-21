#!/usr/bin/env python3
import argparse, csv, math
from collections import Counter, defaultdict
import matplotlib.pyplot as plt

def read_csv(path):
    with open(path, newline='') as f:
        return list(csv.DictReader(f))

def as_int(x):
    try:
        return int(x,0) if isinstance(x,str) and x.lower().startswith('0x') else int(x)
    except:
        return None

def main():
    ap = argparse.ArgumentParser(description="Figuras d) desde router_report.csv")
    ap.add_argument("csv", nargs="?", default="router_report.csv")
    ap.add_argument("--clk", type=int, default=10, help="Periodo de reloj (time units)")
    ap.add_argument("--prefix", default="", help="Prefijo de archivos de salida")
    ap.add_argument("--no_time_series", action="store_true", help="No generar la serie pkt/ciclo")
    args = ap.parse_args()
    out = (args.prefix + "_") if args.prefix else ""

    rows = read_csv(args.csv)
    ok = [r for r in rows if r["status"]=="OK"]
    if not ok:
        print("No hay filas OK en el CSV."); return

    # ---------- (a) Latencia promedio por terminal + barra GLOBAL ----------
    lat_by_term = defaultdict(list)
    all_lat = []
    for r in ok:
        lat = as_int(r["latency"])
        term = as_int(r["rx_term"])
        if lat is not None:
            all_lat.append(lat)
            if term is not None:
                lat_by_term[term].append(lat)
    
    terms = sorted(lat_by_term.keys())                # p.ej., 0..15 (los que aparezcan)
    lat_avg = [sum(v)/len(v) for v in (lat_by_term[t] for t in terms)]
    lat_global = sum(all_lat)/len(all_lat) if all_lat else float("nan")
    
    # Posiciones: terminales en 0..(N-1); GLOBAL en N+0.75 (deja un huequito)
    pos_terms  = list(range(len(terms)))
    pos_global = len(terms) + 0.75
    
    plt.figure()
    plt.bar(pos_terms, lat_avg, label="Por terminal")
    plt.bar([pos_global], [lat_global], label="GLOBAL")  # barra separada
    plt.axhline(lat_global, linestyle="--", alpha=0.6)   # línea de referencia global
    # ticks: todos los terminales + GLOBAL al final
    plt.xticks(pos_terms + [pos_global], [str(t) for t in terms] + ["GLOBAL"])
    plt.xlabel("Terminal de destino (rx_term) y GLOBAL")
    plt.ylabel("Latencia promedio (time units)")
    plt.title("Latencia promedio por terminal + GLOBAL (sólo OK)")
    plt.tight_layout()
    plt.savefig(out + "latency_per_term_with_global.png", dpi=140)
    plt.close()


    # ---------- (b) Ancho de banda global (mín/avg/máx) ----------
    tx_times = [as_int(r["tx_time"]) for r in ok if as_int(r["tx_time"]) is not None]
    rx_times = [as_int(r["rx_time"]) for r in ok if as_int(r["rx_time"]) is not None]
    t0 = min(tx_times) if tx_times else min(rx_times)
    t1 = max(rx_times)
    c0 = t0 // args.clk
    c1 = math.ceil((t1+1)/args.clk)  # exclusivo

    counts = Counter()
    for r in ok:
        cyc = as_int(r["rx_time"]) // args.clk
        counts[cyc] += 1

    series = [counts[c] for c in range(c0, c1)]
    thr_min = min(series) if series else 0.0
    thr_max = max(series) if series else 0.0
    thr_avg = (sum(series) / len(series)) if series else 0.0

    plt.figure()
    plt.bar(["Mínimo","Promedio","Máximo"], [thr_min, thr_avg, thr_max])
    plt.ylabel("Paquetes por ciclo")
    plt.title("Ancho de banda global (mín/prom/máx)")
    plt.tight_layout()
    plt.savefig(out + "throughput_global_min_avg_max.png", dpi=140)
    plt.close()

    if not args.no_time_series:
        xs = list(range(c0, c1))
        ys = series
        plt.figure()
        plt.plot(xs, ys)
        plt.xlabel(f"Ciclo (clk={args.clk})")
        plt.ylabel("Paquetes OK por ciclo")
        plt.title("Ancho de banda global vs tiempo")
        plt.tight_layout()
        plt.savefig(out + "throughput_over_time.png", dpi=140)
        plt.close()

    print("Figuras generadas:")
    print(" -", out + "latency_per_term_with_global.png")
    print(" -", out + "throughput_global_min_avg_max.png")
    if not args.no_time_series:
        print(" -", out + "throughput_over_time.png")

if __name__ == "__main__":
    main()
