# Retro — nach Tag 01–04

Format: Start / Stop / Continue, basierend auf dem tatsächlichen Verlauf der
ersten vier Tage (Repo-Setup, MVP-Planung, CI-Pipeline).

## Was gut lief (Continue)

- **CI-Pipeline mit klarem Gate:** `lint` vor `test` (`needs: lint`) hat sich in
  der Praxis bestätigt — der PR-Lauf zeigte messbar, dass `test` erst nach
  grünem `lint` startet.
- **MVP-in-Phasen-Denken:** Die 3-stufige MVP-Definition fürs Bewertungssystem
  hat direkt zu einem klar abgegrenzten, schnell bau- und testbaren Code-Fragment
  (MVP 1) geführt, statt gleich das ganze Feature zu bauen.
- **Docs vor Code:** `CONTRIBUTING.md` mit Branching-/Merge-Strategie existierte,
  *bevor* der erste echte Feature-Branch/PR entstand — dadurch gab es für den
  ersten "echten" PR bereits eine klare Regel (Squash-Merge, Commit-Format).

## Was nicht gut lief (Stop)

- **Secret im ersten Commit:** `.env` mit (vermutlich Test-)Credentials landete
  im allerersten Commit des ursprünglichen Repos, bevor `.gitignore` sie
  ausschloss — musste per History-Rewrite + Force-Push wieder entfernt werden.
  Kostete Zeit und war vermeidbar.
- **GitHub-Account-Verwechslung:** Mehrfach schlugen Pushes mit 403 fehl, weil
  Git/SSH mit einem anderen GitHub-Account (`marlonburri`) authentifiziert war
  als dem Ziel-Repo-Owner (`marlob03`) — sowohl über HTTPS (Credential Manager)
  als auch über SSH. Mehrfacher Kontextwechsel mitten in der Arbeit.
- **Ungeklärte Repo-Herkunft:** Es gab drei verschiedene Repo-Stände
  (Kurs-Template `tbzdevops/techstyle`, ein Zwischenschritt auf GitLab, dann
  final `marlob03/techstyle-shop-devops`) — das hätte durch eine frühere
  Klärung "wo soll das eigentlich landen?" vermieden werden können.

## Was wir ändern (Try/Massnahmen)

| Massnahme | Owner | Termin |
|---|---|---|
| SSH-Host-Alias für `marlob03` in `~/.ssh/config` einrichten, damit SSH-Pushes nicht mehr auf den falschen Account fallen | Marlon Burri | 2026-09-12 |
| Branch-Protection-Ruleset auf `main` einrichten (Status Checks `lint`+`test` als Pflicht) | Marlon Burri | 2026-09-09 (heute, Kür-Auftrag 1) |
| Secret-Scan vor dem ersten Commit eines neuen Repos einplanen (z.B. `.env` grundsätzlich erst NACH `.gitignore`-Setup anlegen) | Marlon Burri | ab sofort, keine feste Deadline — Teil des Standard-Workflows |
| Alte Classroom-Template-Workflows (`main.yml`, `classroom.yml`, `lint.yml`, `test.yml`, `build.yml`, `deploy.yml`) bewusst behalten oder entfernen entscheiden — aktuell bewusst stehen gelassen, verursachen aber Doppel-Läufe im Actions-Tab | Marlon Burri | 2026-09-16 (nächste Aufräum-Gelegenheit) |
