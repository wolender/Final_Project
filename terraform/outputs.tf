output "app_ip" {
  value = aws_instance.webserver1.public_ip
}
output "ecr_address" {
  value = aws_ecr_repository.ecr_repository.repository_url
}
output "DB_url" {
  value = aws_db_instance.app-database.endpoint
}
output "app_lb_ip" {
  value = aws_lb.load_balancer.dns_name
}
output "db_user" {
  value = aws_db_instance.app-database.username
}
output "db_password" {
  value = aws_db_instance.app-database.password
}