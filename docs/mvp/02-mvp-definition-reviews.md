# MVP-Definition: Bewertungssystem mit Kundenrezensionen

Ausgewähltes Feature aus [01-feature-requests-analysis.md](./01-feature-requests-analysis.md).
Wir definieren 3 MVP-Stufen, jede baut auf der vorherigen auf und liefert für sich
allein bereits Mehrwert (Continuous Delivery kleiner, wertvoller Funktionen).

## MVP 1 — Basis-Bewertung

**Was:** Jeder Nutzer kann ein Produkt mit 1–5 Sternen bewerten und optional einen
Freitext-Kommentar hinterlassen. Die Bewertung erscheint sofort (keine Moderation).
Auf der Produktseite werden Durchschnittsbewertung und Anzahl Bewertungen
angezeigt.

**Warum zuerst:** Kein Login/Kaufnachweis nötig, keine externe Abhängigkeit,
direkt auf bestehender `templates/product.html` umsetzbar (neues DB-Modell
`Review` + ein Formular + eine Route). Liefert den grössten Vertrauens-Effekt
("wir haben überhaupt Bewertungen") für den geringsten Aufwand.

**Out of scope (bewusst):** Moderation, Verifizierung, Sortierung/Filter.

## MVP 2 — Verifizierte & moderierte Bewertungen

**Was:** Nur Nutzer, die das Produkt nachweislich gekauft haben, können es
bewerten ("Verified Purchase"-Badge). Neue Bewertungen gehen zunächst in eine
Moderationswarteschlange im Admin-Panel und werden erst nach Freigabe sichtbar.
Bewertungen können nach "neueste" und "beste Bewertung" sortiert werden.

**Warum als zweites:** Erhöht die Glaubwürdigkeit (Spam/Fake-Reviews werden
deutlich unwahrscheinlicher) und schützt vor Missbrauch — braucht aber eine
Bestellhistorie pro Nutzer, die es aktuell noch nicht gibt, und ist damit
komplexer als MVP 1.

**Out of scope (bewusst):** "Hilfreich"-Bewertungen, KI-gestützte Spam-Erkennung.

## MVP 3 — Community-Signale & Abuse-Erkennung

**Was:** Andere Nutzer können Bewertungen als "hilfreich" markieren, wonach
Standard-Sortierung nach Hilfreichkeit erfolgt. Ein einfaches Regel- oder
ML-basiertes Modell markiert verdächtige Bewertungen (z.B. auffällig viele
5-Sterne-Bewertungen vom selben Account in kurzer Zeit) automatisch zur Prüfung.

**Warum zuletzt:** Höchster Mehrwert für Kaufentscheidungen (Social Proof durch
Sortierung nach Relevanz), aber abhängig von genug Bewertungsvolumen aus MVP 1/2
und von Know-how, das im Team aktuell nicht vorhanden ist (siehe Feedback an
Marketing).

## Übersicht

| MVP | Aufwand | Abhängigkeiten | Kernwert |
|-----|---------|-----------------|----------|
| 1   | klein   | keine            | Bewertungen überhaupt sichtbar |
| 2   | mittel  | Kaufhistorie pro Nutzer | Vertrauenswürdigkeit, Missbrauchsschutz |
| 3   | gross   | genug Datenvolumen, ML-Know-how | Relevanz-Sortierung, Abuse-Erkennung |
