output "app_ip" {
  value = aws_instance.webserver1.public_ip
}
output "ecr_address" {
  value = aws_ecr_repository.ecr_repository.repository_url
}