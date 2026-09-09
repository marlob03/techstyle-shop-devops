# TechStyle eCommerce

## 📋 Projekt-Übersicht

TechStyle ist eine Fashion-eCommerce-Referenzanwendung, gebaut mit Python (Flask) und
SQLite. Dieses Repository ist die Codebasis, die das TechStyle DevOps Team im Rahmen
der Modernisierung mit einem strukturierten Git-Workflow und professionellem Release
Management weiterentwickelt.

**Features:**
- Produktkatalog (mehrere Kategorien)
- Session-basierter Warenkorb
- Checkout (ohne echte Zahlungsabwicklung)
- Admin-Panel unter `/admin`

**Tech Stack:** Python 3.9+ / Flask / SQLAlchemy / SQLite (dev) / HTML, CSS, JS

## 🚀 Quick Start

```bash
./run_dev.sh
```

Das Skript erstellt ein virtuelles Environment, installiert die Abhängigkeiten, seedet
die Datenbank und startet den Dev-Server. Danach: http://localhost:5000

### Manuelles Setup

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env   # eigene Werte eintragen, .env wird NICHT committet
python seed_data.py
python app.py
```

### Deployment

```bash
./deploy.sh
```

Voraussetzung: `~/.ssh/techstyle_prod.pem` existiert und die Server-IP in `deploy.sh`
ist korrekt gesetzt.

## 📁 Verzeichnisstruktur

```
techstyle/
├── app.py                  # Flask app, Routen, SQLAlchemy-Modelle
├── seed_data.py             # Beispieldaten für die lokale DB
├── deploy.sh / run_dev.sh   # Deployment- bzw. Dev-Setup-Skripte
├── requirements.txt
├── templates/                # Jinja2-Views
├── static/                   # CSS, JS, Bilder
├── docs/
│   └── architecture.md       # Architektur-Überblick
├── .github/
│   ├── workflows/             # CI/CD-Pipelines
│   └── pull_request_template.md
├── CONTRIBUTING.md            # Git-Workflow & Branching-Strategie
└── .env.example                # Vorlage für lokale Umgebungsvariablen
```

## 🔗 Links zu wichtigen Dokumenten

- [CONTRIBUTING.md](./CONTRIBUTING.md) — Branching-Strategie, Commit-Konventionen, Review-Prozess
- [docs/architecture.md](./docs/architecture.md) — Architektur-Überblick

## 🤝 Contribution Guidelines

Bevor du beiträgst, lies bitte [CONTRIBUTING.md](./CONTRIBUTING.md) — dort ist der
komplette Git-Workflow (Branching, Merge-Strategie, PR-Anforderungen, Release-Prozess)
dokumentiert.
