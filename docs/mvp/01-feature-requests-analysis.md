# Feature Requests Analysis

Analyse der 5 Marketing-Feature-Requests, übersetzt in Software-Anforderungen.
Jede Anforderung ist grob priorisiert (H = High, M = Medium, L = Low), um sie
später in MVPs aufzuteilen (siehe [02-mvp-definition-reviews.md](./02-mvp-definition-reviews.md)).

## 1. Personalisierte Produktempfehlungen

**Marketing-Wunsch:** AI-basiertes Empfehlungssystem auf Basis von Kauf- und
Browserverhalten, um die Conversion-Rate zu erhöhen.

**Funktionale Anforderungen:**
- FR1 (H): Das System zeigt auf der Produktseite eine Liste ähnlicher Produkte an.
- FR2 (M): Das System berücksichtigt das bisherige Kaufverhalten anderer Kunden
  ("Kunden, die X kauften, kauften auch Y").
- FR3 (L): Das System nutzt ein ML-Modell, um Empfehlungen aus individuellem
  Nutzerverhalten abzuleiten.

**Nicht-funktionale Anforderungen:**
- Empfehlungen müssen die Ladezeit der Produktseite nicht spürbar erhöhen (< 200ms
  zusätzlich).
- Datenschutz: Trackingdaten müssen DSGVO-konform verarbeitet werden (Opt-out
  möglich).

**Offene Fragen:** Woher kommen die Trainingsdaten für ein ML-Modell? Reicht die
aktuelle Datenbasis (SQLite, wenige Testkäufe) überhaupt für FR2/FR3?

## 2. Social Media Sharing

**Marketing-Wunsch:** Share-Buttons für Facebook, Instagram, Twitter auf
Produktseiten, um Reichweite/organischen Traffic zu erhöhen.

**Funktionale Anforderungen:**
- FR1 (H): Auf jeder Produktseite gibt es Buttons zum Teilen auf mind. 2 Plattformen
  (z.B. Facebook, Twitter/X).
- FR2 (M): Der geteilte Link enthält eine Vorschau (Bild, Titel, Preis) via
  Open-Graph-Metadaten.
- FR3 (L): Instagram-Sharing (technisch nur über App-Umleitung möglich, kein
  direktes Web-Share-API).

**Nicht-funktionale Anforderungen:**
- Kein Tracking-Cookie von Drittanbietern soll ohne Consent geladen werden
  (Datenschutz/Performance).

**Offene Fragen:** Instagram bietet keine offizielle Web-Share-API — MVP-tauglich
umsetzbar oder nur Facebook/Twitter zuerst?

## 3. Rabatt- und Gutscheincodes

**Marketing-Wunsch:** Zeitlich begrenzte Rabattcodes / personalisierte Gutscheine
für Marketingaktionen.

**Funktionale Anforderungen:**
- FR1 (H): Im Checkout kann ein Gutscheincode eingegeben werden, der den
  Warenkorb-Preis reduziert.
- FR2 (M): Gutscheine haben ein Gültigkeitsdatum (Start/Ende) und werden nach
  Ablauf automatisch ungültig.
- FR3 (M): Admin kann Gutscheine im Admin-Panel erstellen/deaktivieren.
- FR4 (L): Personalisierte Gutscheine (an bestimmte Nutzer-E-Mail gebunden).

**Nicht-funktionale Anforderungen:**
- Rabattlogik muss serverseitig validiert werden (kein Vertrauen auf Client-Preise).
- Gutscheincodes dürfen nicht kombinierbar/mehrfach einlösbar sein, ausser explizit
  erlaubt.

**Offene Fragen:** Prozentual oder Fixbetrag oder beides? Gibt es
Mindestbestellwerte?

## 4. E-Mail-Marketing-Integration

**Marketing-Wunsch:** Newsletter-Anmeldung + automatisierte Kampagnen (z.B.
Warenkorbabbruch, neue Produkte, Sonderangebote) zur Kundenbindung.

**Funktionale Anforderungen:**
- FR1 (H): Nutzer können sich mit E-Mail-Adresse für einen Newsletter anmelden
  (Double-Opt-in).
- FR2 (M): Bei Warenkorbabbruch (Cart seit X Stunden inaktiv, nicht checked out)
  wird automatisiert eine Erinnerungsmail ausgelöst.
- FR3 (M): Admin kann eine Kampagnen-Mail (z.B. Sonderangebot) an alle
  Newsletter-Abonnenten senden.

**Nicht-funktionale Anforderungen:**
- Anbindung an einen externen E-Mail-Dienst (z.B. SMTP-Provider) statt Eigenbau.
- Abmelde-Link (Unsubscribe) muss in jeder Mail enthalten sein (rechtliche Pflicht).

**Offene Fragen:** Welcher E-Mail-Provider/Dienst wird eingesetzt? Wie wird
"Warenkorbabbruch" technisch erkannt (aktuell ist der Warenkorb nur
session-basiert, nicht persistent pro Nutzer)?

## 5. Bewertungssystem mit Kundenrezensionen

**Marketing-Wunsch:** Kunden können Produkte bewerten/kommentieren, um
Vertrauen aufzubauen und Kaufentscheidungen zu beeinflussen.

**Funktionale Anforderungen:**
- FR1 (H): Nutzer können ein Produkt mit 1–5 Sternen bewerten und optional einen
  Kommentar hinterlassen.
- FR2 (H): Die Produktseite zeigt die durchschnittliche Bewertung und die Anzahl
  Bewertungen an.
- FR3 (M): Nur Nutzer, die das Produkt gekauft haben, können es bewerten
  ("Verified Purchase").
- FR4 (M): Bewertungen können vor Veröffentlichung durch einen Admin moderiert
  werden.
- FR5 (L): Andere Nutzer können Bewertungen als "hilfreich" markieren
  (Sortierung danach).

**Nicht-funktionale Anforderungen:**
- Schutz vor Spam/Missbrauch (z.B. Rate-Limiting pro Nutzer/IP).
- Kommentare müssen vor XSS-Angriffen escaped werden (bestehendes Risiko in
  Jinja2-Templates prüfen).

**Offene Fragen:** Ist eine Kaufhistorie pro Nutzer überhaupt vorhanden (aktuell
kein persistentes Nutzerkonto mit Bestellhistorie)? Wie wird Moderation personell
abgedeckt?

---

**Team-Entscheidung:** Wir wählen **Bewertungssystem mit Kundenrezensionen** als
erstes Feature für die MVP-Definition (siehe Aufgabe 2), da es sich direkt in die
bestehende Produktseite (`templates/product.html`) integrieren lässt, ohne auf
fehlende Voraussetzungen wie ML-Infrastruktur (Empfehlungen) oder einen externen
E-Mail-Dienst (Newsletter) angewiesen zu sein.
