# Epic & User Stories: Bewertungssystem mit Kundenrezensionen

## Epic

**Epic: Kundenbewertungen für Produkte**
Als Shop wollen wir Kund:innen ermöglichen, Produkte zu bewerten und zu
kommentieren, damit neue Kund:innen Vertrauen in die Kaufentscheidung gewinnen
und die Conversion-Rate steigt. Umfasst MVP 1–3 aus
[02-mvp-definition-reviews.md](./02-mvp-definition-reviews.md).

## INVEST-Kriterien (Referenz)

Jede Story unten erfüllt: **I**ndependent (einzeln lieferbar), **N**egotiable
(Umsetzungsdetails offen), **V**aluable (eigenständiger Nutzen), **E**stimable
(schätzbar), **S**mall (in einem Sprint umsetzbar), **T**estable (klare
Akzeptanzkriterien).

---

### MVP 1 — Basis-Bewertung

**Story 1.1 — Produkt bewerten**
Als Kundin/Kunde möchte ich ein Produkt mit 1–5 Sternen bewerten, damit ich
meine Erfahrung mit anderen teilen kann.
- Akzeptanzkriterien:
  - Given ich bin auf einer Produktseite, When ich 1–5 Sterne auswähle und
    absende, Then wird die Bewertung gespeichert und sofort angezeigt.
  - Ohne Sternevergabe kann nicht abgesendet werden (Pflichtfeld).
- Schätzung: 3 SP

**Story 1.2 — Kommentar zur Bewertung hinzufügen**
Als Kundin/Kunde möchte ich optional einen Kommentar zu meiner Bewertung
schreiben, damit ich meine Meinung genauer begründen kann.
- Akzeptanzkriterien:
  - Given ich bewerte ein Produkt, When ich einen Kommentar (max. 500 Zeichen)
    eingebe, Then wird er zusammen mit der Sterne-Bewertung gespeichert.
  - Kommentarfeld ist optional (Story 1.1 funktioniert auch ohne).
- Schätzung: 2 SP

**Story 1.3 — Durchschnittsbewertung anzeigen**
Als Besucher:in möchte ich auf der Produktseite die Durchschnittsbewertung und
Anzahl Bewertungen sehen, damit ich die Produktqualität schnell einschätzen
kann.
- Akzeptanzkriterien:
  - Given ein Produkt hat ≥1 Bewertung, When ich die Produktseite öffne, Then
    sehe ich Ø-Sterne (gerundet auf 0.5) und die Anzahl Bewertungen.
  - Given ein Produkt hat 0 Bewertungen, Then wird "Noch keine Bewertungen"
    angezeigt statt einer Zahl.
- Schätzung: 2 SP

**Story 1.4 — Bewertungsliste auf der Produktseite**
Als Besucher:in möchte ich alle Bewertungen zu einem Produkt lesen können,
damit ich mir ein umfassendes Bild machen kann.
- Akzeptanzkriterien:
  - Given ein Produkt hat Bewertungen, When ich die Produktseite öffne, Then
    sehe ich eine Liste mit Sterne + Kommentar + Datum, neueste zuerst.
- Schätzung: 3 SP

### MVP 2 — Verifiziert & moderiert

**Story 2.1 — Nur Käufer:innen können bewerten**
Als Shop-Betreiber möchte ich, dass nur Kund:innen mit nachgewiesenem Kauf ein
Produkt bewerten können, damit Bewertungen glaubwürdig bleiben.
- Akzeptanzkriterien:
  - Given ich habe ein Produkt nicht gekauft, When ich versuche zu bewerten,
    Then wird die Aktion abgelehnt mit Hinweis auf fehlenden Kaufnachweis.
  - Given ich habe gekauft, Then kann ich bewerten und die Bewertung erhält ein
    "Verified Purchase"-Badge.
- Schätzung: 8 SP (abhängig von Bestellhistorie pro Nutzer)

**Story 2.2 — Bewertungen moderieren**
Als Admin möchte ich neue Bewertungen vor Veröffentlichung freigeben, damit
keine unangemessenen Inhalte live gehen.
- Akzeptanzkriterien:
  - Given eine neue Bewertung wurde abgeschickt, Then erscheint sie zunächst
    nur in einer Moderationswarteschlange im Admin-Panel, nicht öffentlich.
  - Given ein Admin genehmigt eine Bewertung, Then wird sie auf der
    Produktseite sichtbar.
- Schätzung: 5 SP

**Story 2.3 — Bewertungen sortieren**
Als Besucher:in möchte ich Bewertungen nach "neueste" oder "beste Bewertung"
sortieren können, damit ich relevante Bewertungen schneller finde.
- Akzeptanzkriterien:
  - Given eine Produktseite mit ≥2 Bewertungen, When ich die Sortierung
    wechsle, Then ändert sich die Reihenfolge entsprechend.
- Schätzung: 2 SP

### MVP 3 — Community & Abuse-Erkennung

**Story 3.1 — Bewertung als hilfreich markieren**
Als Besucher:in möchte ich eine Bewertung als "hilfreich" markieren, damit
relevante Bewertungen für andere sichtbarer werden.
- Akzeptanzkriterien:
  - Given eine veröffentlichte Bewertung, When ich "Hilfreich" anklicke, Then
    erhöht sich der Zähler um 1 (max. 1 Stimme pro Nutzer:in/Bewertung).
  - Standard-Sortierung wechselt zu "Hilfreichste zuerst", sobald Stimmen
    vorhanden sind.
- Schätzung: 3 SP

**Story 3.2 — Verdächtige Bewertungen automatisch markieren**
Als Admin möchte ich, dass auffällige Bewertungsmuster (z.B. viele
5-Sterne-Bewertungen vom selben Account in kurzer Zeit) automatisch markiert
werden, damit ich Fake-Reviews gezielt prüfen kann.
- Akzeptanzkriterien:
  - Given ein Account gibt >5 Bewertungen in <10 Minuten ab, Then werden diese
    Bewertungen mit einem "Zur Prüfung"-Flag versehen statt automatisch
    veröffentlicht.
- Schätzung: 8 SP (Recherche-Aufwand für Regelwerk/Modell eingeschlossen)

---

## Als GitHub Issues anlegen

Diese Befehle **selbst ausführen** (legt Epic + Stories als Issues an, mit
Labels für Epic/MVP-Zuordnung):

```bash
cd "C:\Users\marlo\git\devops-module\techstyle-shop-devops"

gh label create epic --color "5319E7" --description "Epic" --force
gh label create user-story --color "0E8A16" --description "User Story" --force
gh label create mvp-1 --color "FBCA04" --force
gh label create mvp-2 --color "D93F0B" --force
gh label create mvp-3 --color "B60205" --force

gh issue create --title "Epic: Kundenbewertungen für Produkte" \
  --label epic \
  --body "Als Shop wollen wir Kund:innen ermöglichen, Produkte zu bewerten und zu kommentieren, damit neue Kund:innen Vertrauen gewinnen und die Conversion-Rate steigt. Siehe docs/mvp/02-mvp-definition-reviews.md."

gh issue create --title "Produkt mit 1-5 Sternen bewerten" --label "user-story,mvp-1" \
  --body "Als Kundin/Kunde möchte ich ein Produkt mit 1-5 Sternen bewerten, damit ich meine Erfahrung teilen kann. AC: Pflichtfeld Sterne, sofort sichtbar. (3 SP)"

gh issue create --title "Kommentar zur Bewertung hinzufügen" --label "user-story,mvp-1" \
  --body "Als Kundin/Kunde möchte ich optional einen Kommentar zu meiner Bewertung schreiben. AC: optionales Feld, max. 500 Zeichen. (2 SP)"

gh issue create --title "Durchschnittsbewertung auf Produktseite anzeigen" --label "user-story,mvp-1" \
  --body "Als Besucher:in möchte ich die Ø-Bewertung und Anzahl Bewertungen sehen. AC: Rundung auf 0.5, Leerzustand 'Noch keine Bewertungen'. (2 SP)"

gh issue create --title "Bewertungsliste auf Produktseite anzeigen" --label "user-story,mvp-1" \
  --body "Als Besucher:in möchte ich alle Bewertungen lesen können. AC: Liste mit Sterne+Kommentar+Datum, neueste zuerst. (3 SP)"

gh issue create --title "Nur verifizierte Käufer können bewerten" --label "user-story,mvp-2" \
  --body "Als Shop-Betreiber möchte ich, dass nur Käufer:innen bewerten können ('Verified Purchase'). (8 SP)"

gh issue create --title "Bewertungen vor Veröffentlichung moderieren" --label "user-story,mvp-2" \
  --body "Als Admin möchte ich neue Bewertungen freigeben, bevor sie live gehen. (5 SP)"

gh issue create --title "Bewertungen sortierbar machen" --label "user-story,mvp-2" \
  --body "Als Besucher:in möchte ich Bewertungen nach neueste/beste sortieren. (2 SP)"

gh issue create --title "Bewertung als hilfreich markieren" --label "user-story,mvp-3" \
  --body "Als Besucher:in möchte ich eine Bewertung als hilfreich markieren können. (3 SP)"

gh issue create --title "Verdächtige Bewertungsmuster automatisch flaggen" --label "user-story,mvp-3" \
  --body "Als Admin möchte ich auffällige Bewertungsmuster automatisch markiert bekommen. (8 SP)"
```

Danach: alle Issues im GitHub Project (siehe
[04-kanban-board.md](./04-kanban-board.md)) der Spalte **Backlog** zuordnen.
