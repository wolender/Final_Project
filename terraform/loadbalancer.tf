resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.load_balancer.arn

  port = 80

  protocol = "HTTP"
  tags = {
      Name = "tf-lbl"
      Owner = var.owner
      Project = var.project
  }
  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_lb_target_group" "instances" {
  name     = "web-servers-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
  tags = {
      Name = "tf-tg"
      Owner = var.owner
      Project = var.project
  }

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "web_server_1" {
  target_group_arn = aws_lb_target_group.instances.arn
  target_id        = aws_instance.webserver1.id
  port             = 80
}


resource "aws_lb_listener_rule" "instances" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100
  tags = {
      Name = "tf-rule"
      Owner = var.owner
      Project = var.project
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instances.arn
  }
}
resource "aws_lb" "load_balancer" {
  name               = "web-app-lb"
  load_balancer_type = "application"
  subnets          = [aws_subnet.my_subnet1.id,aws_subnet.my_subnet2.id]
  security_groups    = [aws_security_group.alb-sgroup.id]
  
  tags = {
      Name = "tf-alb"
      Owner = var.owner
      Project = var.project
  }

}