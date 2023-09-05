resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name    = "wolender-tf-vpc"
    Owner   = var.owner
    Project = var.project
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name    = "wolender-tf-gate"
    Owner   = var.owner
    Project = var.project
  }
}

resource "aws_subnet" "my_subnet1" {
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = var.az1
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name    = "wolender-tf-subnet1"
    Owner   = var.owner
    Project = var.project
  }
}

resource "aws_subnet" "my_subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.az2
  tags = {
    Name    = "wolender-tf-subnet2"
    Owner   = var.owner
    Project = var.project
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "wolender-db-subnet-group"
  subnet_ids = [aws_subnet.my_subnet1.id, aws_subnet.my_subnet2.id]

  tags = {
    Name    = "wolender-db-subnet-group"
    Owner   = var.owner
    Project = var.project
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name    = "wolender-tf-rtable"
    Owner   = var.owner
    Project = var.project
  }
}

resource "aws_route_table_association" "my_subnet_association1" {
  subnet_id      = aws_subnet.my_subnet1.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "my_subnet_association2" {
  subnet_id      = aws_subnet.my_subnet2.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_security_group" "instances" {
  name        = "instances-sgroup"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name    = "wolender-tf-sg"
    Owner   = var.owner
    Project = var.project
  }

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb-sgroup" {
  name        = "load-balancer-group"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name    = "wolender-tf-sg"
    Owner   = var.owner
    Project = var.project
  }

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.access_ip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "DB_sec_group" {
  name        = "wolender-db-sec-group"
  description = "HTTP inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name    = "wolender-tf-db-group"
    Owner   = var.owner
    Project = var.project
  }

  ingress {
    description = "MySQL database access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group_rule" "my_outbound_rule" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.instances.id
}