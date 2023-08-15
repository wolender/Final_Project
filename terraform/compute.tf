
resource "aws_instance" "temp-web-server" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.aws_key
  subnet_id = aws_subnet.my_subnet1.id
  security_groups = [aws_security_group.instances.id]
  associate_public_ip_address  = true

  user_data       = <<-EOF
              #!/bin/bash
              yum install httpd -y
              service httpd enable
              service httpd start
              EOF
  tags = {
      Name = "temp-web-server"
      Owner = var.owner
      Project = var.project
  }
}