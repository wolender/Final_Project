
resource "aws_iam_instance_profile" "instance_profile" {
  name = "wolender-instance-profile"

  role = "allow_ec2_ecr"
  tags = {
      Name = "wolender_instance_pofile"
      Owner = var.owner
      Project = var.project
  }
}

resource "aws_instance" "webserver1" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.aws_key
  subnet_id = aws_subnet.my_subnet1.id
  security_groups = [aws_security_group.instances.id]
  associate_public_ip_address  = true
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  user_data       = <<-EOF
              #!/bin/bash
              yum install docker -y
              service docker enable
              service docker start
              EOF
  tags = {
      Name = "wolender-webserver1"
      Owner = var.owner
      Project = var.project
  }
}

resource "aws_instance" "webserver1" {
  ami           = var.ami
  instance_type = var.SQ_instance_type
  key_name = var.aws_key
  subnet_id = aws_subnet.my_subnet1.id
  security_groups = [aws_security_group.instances.id]
  associate_public_ip_address  = true

  user_data       = <<-EOF
              #!/bin/bash
              yum install docker -y
              service docker enable
              service docker start
              EOF
  tags = {
      Name = "wolender-SQ-scanner"
      Owner = var.owner
      Project = var.project
  }
}
