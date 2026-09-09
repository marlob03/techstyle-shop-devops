# Value Stream Map — Bewertungssystem (MVP 1)

Skizze des Value Streams für MVP 1 aus
[02-mvp-definition-reviews.md](./02-mvp-definition-reviews.md): eine Bewertung
von der Kundeneingabe bis zur Sichtbarkeit auf der Produktseite.

```
 Kund:in                Flask App                    SQLite
   │                        │                            │
   │  öffnet Produktseite   │                            │
   ├───────────────────────►│  SELECT products, reviews  │
   │                        ├───────────────────────────►│
   │                        │◄───────────────────────────┤
   │◄───────────────────────┤  render product.html       │
   │  (Ø-Rating, Liste)     │                            │
   │                        │                            │
   │  wählt Sterne + Text   │                            │
   ├───────────────────────►│  POST /product/<id>/review │
   │                        │  validiert rating 1-5      │
   │                        ├───────────────────────────►│ INSERT reviews
   │                        │◄───────────────────────────┤
   │◄───────────────────────┤  redirect → product page   │
   │  sieht eigene Bewertung│                            │
   │  sofort (kein Wartezeit)                            │
```

## Prozessschritte & Zeiten (Schätzung, MVP 1)

| Schritt | Wer/Was | Dauer | Wertschöpfend? |
|---|---|---|---|
| Produktseite öffnen | Flask-Route + 2 DB-Queries | < 50 ms | ✅ (Kaufentscheidung informieren) |
| Sterne + Kommentar eingeben | Kund:in (manuell) | 10–30 s | ✅ (Kern des Features) |
| Formular absenden | POST-Request | < 50 ms | ✅ |
| Validierung (1–5) | Flask, serverseitig | < 1 ms | ⚠️ notwendig, aber nicht direkt wertschöpfend (Datenqualität) |
| Speichern in SQLite | `INSERT INTO reviews` | < 10 ms | ✅ |
| Redirect + Re-Render | Flask | < 50 ms | ✅ (sofortiges Feedback) |

**Lead Time (Kund:in klickt Absenden → sieht eigene Bewertung):** < 200 ms —
kein Wartezustand, keine Warteschlange (bewusst, da MVP 1 **keine Moderation**
hat, siehe MVP 2). Der einzige "Wartepunkt" im Gesamtprozess ist bei MVP 2/3
die Moderationswarteschlange — dort entsteht der erste echte Puffer im Value
Stream.

## Engpässe / Muda, die MVP 1 bewusst in Kauf nimmt

- Keine Moderation → Risiko für Spam/Fake-Reviews (wird erst in MVP 2 addressiert,
  siehe [02-mvp-definition-reviews.md](./02-mvp-definition-reviews.md)).
- Keine Verifizierung des Kaufs → jede:r kann bewerten, auch ohne Kauf.

Diese bewussten Lücken sind der Grund, warum wir das Feature in Phasen liefern
(siehe [03-marketing-feedback-email.md](./03-marketing-feedback-email.md)) statt
alles auf einmal zu bauen.
