# SonarQube Server (Terraform)

Stellt SonarQube Community Edition auf einer EC2-Instanz bereit — via
Docker Compose (SonarQube + PostgreSQL), automatisiert über Cloud-Init.

## Ressourcen

- **EC2 Instance** (`t3.large`, min. 8 GB RAM) mit Ubuntu 24.04 LTS
- **Security Group**: SSH (22) + SonarQube Web UI (9000)
- **Elastic IP** für eine stabile Adresse über Neustarts hinweg
- **Cloud-Init**: installiert Docker, schreibt `docker-compose.yml` und
  startet SonarQube + PostgreSQL als systemd-Service

## Verwendung

```powershell
cd infra\sonarqube

# Pflicht: DB-Passwort setzen, z.B. per Umgebungsvariable (nicht committen!)
$env:TF_VAR_sonar_db_password = "<sicheres-passwort>"

terraform init
terraform plan
terraform apply
```

Nach ca. 5 Minuten ist SonarQube erreichbar unter der Ausgabe `sonarqube_url`.

## Konfiguration

Alle Variablen in [`variables.tf`](variables.tf) haben sinnvolle Defaults,
ausser `sonar_db_password` (bewusst ohne Default). Anpassbar u.a.:

| Variable | Zweck |
|---|---|
| `aws_region` | Ziel-Region (Default `eu-central-1`) |
| `instance_type` | Default `t3.large` — SonarQube braucht min. 8 GB RAM |
| `allowed_ssh_cidr` / `allowed_web_cidr` | Zugriff einschränken (Default offen für den Unterricht) |
| `ssh_public_key_path` | Eigener SSH-Public-Key für den Zugriff auf die VM |

## Nach dem Deployment

1. SonarQube-URL öffnen (`terraform output sonarqube_url`)
2. Login mit `admin` / `admin`, Passwort sofort ändern
3. Projekt-Token erzeugen und als GitHub Secret `SONAR_TOKEN` hinterlegen
4. `SONAR_HOST_URL` (= `sonarqube_url`) ebenfalls als GitHub Secret hinterlegen
5. Damit ist die Pipeline in [`.github/workflows/ci.yml`](../../.github/workflows/ci.yml)
   (Job `sonarqube`) einsatzbereit

## Cleanup

```powershell
terraform destroy
```

## Sicherheitshinweise

- `sonar_db_password` wird nie im Code hinterlegt — per `TF_VAR_...` oder
  einer lokalen, gitignoreten `terraform.tfvars` setzen.
- `allowed_ssh_cidr` / `allowed_web_cidr` sind standardmässig offen
  (`0.0.0.0/0`) für den einfachen Unterrichtseinsatz. Für produktive
  Nutzung auf bekannte IP-Ranges einschränken.
- Terraform-State (`*.tfstate`) und `.terraform/` sind über die Root
  `.gitignore` ausgeschlossen — niemals committen (enthält Secrets im Klartext).
