
resource "aws_instance" "webserver1" {
  ami           = var.ami
  instance_type = var.instance_type
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
      Name = "webserver1"
      Owner = var.owner
      Project = var.project
  }
}