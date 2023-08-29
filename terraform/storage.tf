# resource "aws_db_parameter_group" "parameter_group" {
#   name   = "education"
#   family = "postgres14"

#   parameter {
#     name  = "log_connections"
#     value = "1"
#   }
# }

resource "aws_db_instance" "example" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "admin"
  password             = "mysecretpassword"
  parameter_group_name = "default.mysql5.7"

  tags = {
    Name    = "wolender-database"
    Owner   = var.owner
    Project = var.project
  }
}


resource "aws_ecr_repository" "ecr_repository" {
  name                 = "wolender-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name    = "wolender-ecr"
    Owner   = var.owner
    Project = var.project
  }
}
