# CI Pipeline Audit

Dokumentiert jeden Step von `.github/workflows/ci.yml`: Zweck und gemessene
Laufzeit, vorher/nachher (vor bzw. nach `cache: pip` + `concurrency`).

## Workflow-Konfiguration

| Element | Zweck |
|---|---|
| `on: push` (nur `main`) | Validiert jeden Merge nach `main` erneut (Post-Merge-Sicherheitsnetz). |
| `on: pull_request` (Ziel `main`) | Gibt Feedback auf jedem Branch, sobald ein PR gegen `main` offen ist — deckt automatisch jeden Branch-Namen ab (siehe CONTRIBUTING.md, GitHub Flow). |
| `concurrency: ci-${{ github.workflow }}-${{ github.ref }}`, `cancel-in-progress: true` | Bricht einen laufenden Run ab, sobald auf denselben Branch/PR erneut gepusht wird — verhindert, dass mehrere überholte Läufe parallel Runner-Minuten verbrauchen. |

## Job `lint` — Code Quality (flake8)

| Step | Zweck | Vorher (kein Cache) | Nachher (Cache, warm) |
|---|---|---|---|
| `actions/checkout@v4` | Holt den Code auf den Runner | 1 s | 1 s |
| `actions/setup-python@v5` (inkl. `cache: pip`) | Installiert Python 3.11; mit `cache: pip` zusätzlich: stellt den pip-Cache wieder her (Key basiert auf Hash von `requirements.txt`) | 0 s (kein Cache-Schritt) | 3 s (Cache-Download + Extract) |
| `Install dependencies` (`pip install -r requirements.txt`) | Installiert Flask, pytest, flake8 etc. | 5 s | 4 s |
| `Run flake8` | Lint von `tests/` + `conftest.py` | 1 s | 1 s |
| **Job gesamt** | | **7 s** | **9 s** |

## Job `test` — Automated Tests (pytest)

`needs: lint` — startet erst, wenn `lint` grün ist.

| Step | Zweck | Vorher | Nachher |
|---|---|---|---|
| `actions/checkout@v4` | Code holen | 1 s | 0 s |
| `actions/setup-python@v5` (`cache: pip`) | Python + Cache-Restore | 0 s | 3 s |
| `Install dependencies` | Dependencies installieren | 6 s | 5 s |
| `Run tests` (`pytest tests/ -v --tb=short`) | Führt Unit- + Integrationstest aus | < 1 s | < 1 s |
| **Job gesamt** | | **8 s** | **10 s** |

**End-to-end (lint-Start → test-Ende):** vorher 20 s, nachher 25 s.

## Ehrlicher Befund: Caching hat hier (noch) keinen Netto-Vorteil

Der reine `Install dependencies`-Schritt wurde durch den Cache leicht schneller
(5 s → 4 s, 6 s → 5 s), aber das Wiederherstellen des Caches selbst
(`actions/setup-python`-Cache-Restore) kostet ca. 3 s pro Job — bei diesem
kleinen Dependency-Footprint (10 Pakete, keine schweren Wheels wie NumPy/Torch)
frisst der Cache-Restore-Overhead die Einsparung praktisch komplett auf. Netto
ist die Pipeline mit Cache aktuell **nicht schneller, tendenziell sogar
minimal langsamer** (Messrauschen durch Runner-Zuteilung eingeschlossen).

**Warum wir `cache: pip` trotzdem drinlassen:** Der Nutzen skaliert mit der
Anzahl/Grösse der Dependencies. Sobald grössere Pakete dazukommen (z.B. ein
ML-Modell für die Produktempfehlungen, Pandas, o.ä.) oder die Pipeline
deutlich häufiger läuft, kippt die Rechnung zugunsten des Caches. Für den
aktuellen Stand ist der Effekt vernachlässigbar, aber nicht schädlich.

**`concurrency`** lässt sich nicht an einer einzelnen Laufzeit ablesen — der
Nutzen zeigt sich erst, wenn mehrfach schnell hintereinander gepusht wird:
ohne `concurrency` würden alle Runs bis zum Ende durchlaufen (Runner-Minuten
verschwendet); mit `concurrency` wird jeder überholte Run sofort abgebrochen,
sobald ein neuerer für denselben Branch startet.

## Entscheidung zu `needs: lint` (nicht aufgelöst)

Der Auftrag fragt, ob sich `needs: lint` "wo sinnvoll" auflösen lässt (`lint`
und `test` parallel statt sequenziell laufen zu lassen). Wir behalten die
Kette bewusst bei:

- Der Zeitgewinn durch Parallelisierung wäre bei der aktuellen Pipeline-Grösse
  gering (test-Job dauert ohnehin nur ~10 s).
- Der eigentliche Zweck von `needs: lint` ist nicht in erster Linie Zeit
  sparen, sondern ein **Fail-fast-Gate**: bei einem Lint-Fehler sollen keine
  (später potenziell teureren) Tests mehr laufen. Dieser Wert bleibt unabhängig
  von der aktuellen Pipeline-Grösse bestehen und wird bei wachsender Test-Suite
  wichtiger, nicht unwichtiger.

## Referenzen

- Workflow-Datei: [`.github/workflows/ci.yml`](../.github/workflows/ci.yml)
- Vorher-Lauf: [PR #12, Run 34343433778](https://github.com/marlob03/techstyle-shop-devops/actions/runs/34343433778)
- Nachher-Lauf (Cache warm): [PR #13, Run 34344383293 (Re-run)](https://github.com/marlob03/techstyle-shop-devops/actions/runs/34344383293)
