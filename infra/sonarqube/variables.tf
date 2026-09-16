variable "aws_region" {
  description = "AWS-Region für das SonarQube-Deployment"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Präfix für benannte Ressourcen (Tags, Security Group, Key Pair)"
  type        = string
  default     = "techstyle-sonarqube"
}

variable "instance_type" {
  description = "EC2-Instanztyp (SonarQube braucht mind. 8 GB RAM)"
  type        = string
  default     = "t3.large"
}

variable "allowed_ssh_cidr" {
  description = "CIDR-Block, der SSH (Port 22) erreichen darf. Für echte Deployments auf die eigene IP einschränken."
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_web_cidr" {
  description = "CIDR-Block, der die SonarQube-Web-UI (Port 9000) erreichen darf."
  type        = string
  default     = "0.0.0.0/0"
}

variable "ssh_public_key_path" {
  description = "Pfad zum öffentlichen SSH-Key, der auf die VM injiziert wird."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "sonar_db_user" {
  description = "PostgreSQL-Benutzer für die SonarQube-Datenbank"
  type        = string
  default     = "sonar"
}

variable "sonar_db_password" {
  description = "PostgreSQL-Passwort für die SonarQube-Datenbank. In terraform.tfvars (gitignored) oder TF_VAR_sonar_db_password setzen — niemals committen."
  type        = string
  sensitive   = true
}
