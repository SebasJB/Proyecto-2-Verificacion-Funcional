#!/usr/bin/env python3
import argparse, csv
from collections import Counter, defaultdict
import math
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

    # ---------- (a) Latencia promedio por terminal ----------
    lat_by_term = defaultdict(list)
    for r in ok:
        lat = as_int(r["latency"])
        term = as_int(r["rx_term"])
        if lat is not None and term is not None:
            lat_by_term[term].append(lat)

    terms = sorted(lat_by_term.keys())
    lat_avg = [sum(v)/len(v) for v in (lat_by_term[t] for t in terms)]

    plt.figure()
    plt.bar([str(t) for t in terms], lat_avg)
    plt.xlabel("Terminal de destino (rx_term)")
    plt.ylabel("Latencia promedio (time units)")
    plt.title("Latencia promedio por terminal (sólo OK)")
    plt.tight_layout()
    plt.savefig(out + "latency_per_term.png", dpi=140)
    plt.close()

    # ---------- (b) Ancho de banda global (mín/avg/máx) ----------
    # Ventana de ciclos: desde el primer TX al último RX (incluye ciclos sin recepción)
    tx_times = [as_int(r["tx_time"]) for r in ok if as_int(r["tx_time"]) is not None]
    rx_times = [as_int(r["rx_time"]) for r in ok if as_int(r["rx_time"]) is not None]
    t0 = min(tx_times) if tx_times else min(rx_times)
    t1 = max(rx_times)
    c0 = t0 // args.clk
    c1 = math.ceil((t1+1)/args.clk)  # exclusivo

    # Conteo de OK por ciclo (usamos rx_time como entrega)
    counts = Counter()
    for r in ok:
        cyc = as_int(r["rx_time"]) // args.clk
        counts[cyc] += 1

    # Serie densa con ceros en ciclos sin recepción
    series = [counts[c] for c in range(c0, c1)]
    thr_min = min(series)
    thr_max = max(series)
    thr_avg = sum(series) / len(series) if series else 0.0

    # Barras globales (mín/avg/máx)
    plt.figure()
    labels = ["Mínimo","Promedio","Máximo"]
    vals   = [thr_min, thr_avg, thr_max]
    plt.bar(labels, vals)
    plt.ylabel("Paquetes por ciclo")
    plt.title("Ancho de banda global (mín/prom/máx)")
    plt.tight_layout()
    plt.savefig(out + "throughput_global_min_avg_max.png", dpi=140)
    plt.close()

    # (Opcional) Serie pkt/ciclo para inspección
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
    print(" -", out + "latency_per_term.png")
    print(" -", out + "throughput_global_min_avg_max.png")
    if not args.no_time_series:
        print(" -", out + "throughput_over_time.png")

if __name__ == "__main__":
    main()
