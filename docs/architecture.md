# Architecture

## Overview

TechStyle is a single-service Flask application: server-rendered HTML (Jinja2)
backed by SQLAlchemy over SQLite.

```
Browser
  │
  ▼
Flask app (app.py)
  ├── routes: catalogue, cart, checkout, auth, admin
  ├── templates/  (Jinja2 views)
  ├── static/     (CSS, JS, images)
  └── SQLAlchemy models
        │
        ▼
   SQLite (dev: /tmp/techstyle.db)
```

## Components

- **`app.py`** — Flask app, routes, and SQLAlchemy models.
- **`seed_data.py`** — populates the database with sample products for local dev.
- **`templates/`** — server-rendered pages (product listing, cart, checkout, admin).
- **`static/`** — CSS/JS/images served directly by Flask.
- **`deploy.sh`** — pushes the app to the production host over SSH.

## Data flow

1. Product catalogue and cart state are read from/written to SQLite via SQLAlchemy.
2. Shopping cart is session-based (no separate cart service).
3. Checkout does not integrate a real payment provider — it's a stub for the course.

## Notes for future work

- Database is SQLite and file-based — fine for development, not for concurrent
  production use. A managed Postgres instance is a likely future step.
- No authentication guard on `/admin` yet.
- See [CONTRIBUTING.md](../CONTRIBUTING.md) for how changes to this architecture
  should be branched, reviewed, and released.
