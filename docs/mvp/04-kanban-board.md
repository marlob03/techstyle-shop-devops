# Kanban-Board für TechStyle

Wir nutzen ein **GitHub Project (Board-Ansicht)** im Repository, statt eines
externen Tools, damit Issues/PRs direkt mit den Karten verknüpft sind.

## Spalten

| Spalte | Bedeutung |
|---|---|
| **Backlog** | Alle erfassten Aufgaben, noch nicht zur Umsetzung geplant |
| **To Do** | Für den nächsten Sprint/die nächste Iteration eingeplant |
| **In Progress** | Aktuell in Bearbeitung (WIP-Limit empfohlen: 1–2 pro Person) |
| **Code Review / Testing** | PR offen, wird geprüft oder getestet |
| **Ready for Deployment** | Gemerged, wartet auf den nächsten Release |
| **Done** | Ausgeliefert (in Production) |
| **Blocked** *(optional)* | Kann aktuell nicht weiterbearbeitet werden (Grund als Kommentar auf der Karte) |

Eine Karte wandert links nach rechts; **Blocked** ist ein Seitenzweig aus
"In Progress" oder "Code Review / Testing" und wird nach Klärung wieder
zurückverschoben.

## Setup (manuell, im Browser)

1. GitHub-Repo → Tab **Projects** → **New project** → Template **Board**.
2. Titel: `TechStyle Kanban`.
3. Die drei Standard-Spalten (`Todo`, `In Progress`, `Done`) umbenennen bzw.
   ergänzen, bis exakt diese Reihenfolge steht:
   `Backlog → To Do → In Progress → Code Review / Testing → Ready for Deployment → Done`
   (optional zusätzlich `Blocked`).
4. Unter **Settings** des Projekts ein Single-Select-Feld `Status` mit genau
   diesen Werten anlegen/anpassen (Board-Spalten basieren auf diesem Feld).
5. Alle Issues aus Aufgabe 5 (`gh issue create`, siehe
   [05-user-stories.md](./05-user-stories.md)) dem Project hinzufügen und in
   **Backlog** einsortieren.

> Wir richten das Board bewusst manuell über die GitHub-UI ein statt per CLI,
> weil die Spalten-Konfiguration (Single-Select-Feld mit 6–7 Werten, Reihenfolge)
> in der Web-Oberfläche deutlich schneller und übersichtlicher geht als über
> `gh project field-create`.
