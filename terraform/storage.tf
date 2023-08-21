# resource "aws_db_parameter_group" "parameter_group" {
#   name   = "education"
#   family = "postgres14"

#   parameter {
#     name  = "log_connections"
#     value = "1"
#   }
# }

# resource "aws_db_instance" "webapp_db" {
#   identifier             = "webapp_db"
#   instance_class         = "db.t3.micro"
#   allocated_storage      = 1
#   engine                 = "postgres"
#   engine_version         = "14.1"
#   username               = "login"
#   password               = var.db_password
#   db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
#   vpc_security_group_ids = [aws_security_group.instances.id]
#   parameter_group_name   = aws_db_parameter_group.parameter_group.name
#   publicly_accessible    = true
#   skip_final_snapshot    = true

#   tags = {
#       Name = "wolender-database"
#       Owner = var.owner
#       Project = var.project
#   }
# }

resource "aws_ecr_repository" "ecr_repository" {
  name = "wolender-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
      Name = "wolender-ecr"
      Owner = var.owner
      Project = var.project
  }
}
