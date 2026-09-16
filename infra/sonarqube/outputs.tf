output "sonarqube_url" {
  value       = "http://${aws_eip.sonarqube.public_ip}:9000"
  description = "URL der SonarQube-Instanz (Start dauert nach dem Boot ca. 5 Minuten)"
}

output "sonarqube_ip" {
  value       = aws_eip.sonarqube.public_ip
  description = "Elastic IP der SonarQube-VM"
}

output "ssh_command" {
  value       = local.ssh_public_key != null ? "ssh -i ${var.ssh_public_key_path} ubuntu@${aws_eip.sonarqube.public_ip}" : "Kein SSH-Key unter ${var.ssh_public_key_path} gefunden."
  description = "Befehl für den SSH-Zugriff auf die VM"
}

output "sonarqube_login_hint" {
  value       = "Erstlogin: admin / admin — danach sofort das Passwort ändern."
  description = "Hinweis zum initialen Login"
}
