
resource "aws_db_instance" "app-database" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "wolender-db"
  username               = var.MySQL_login
  password               = var.MySQL_passwword
  parameter_group_name   = "default.mysql5.7"
  vpc_security_group_ids = [aws_security_group.DB_sec_group.id]
  subnets                = [aws_subnet.my_subnet1.id, aws_subnet.my_subnet2.id]

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
