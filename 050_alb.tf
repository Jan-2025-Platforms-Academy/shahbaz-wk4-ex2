resource "aws_alb" "this" {
  name                       = "shahbaz-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb-sg.id]
  subnets                    = [aws_subnet.public_subnet_2.id, aws_subnet.public_subnet_3.id]
  enable_deletion_protection = false
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.this.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:eu-west-2:841162714039:certificate/ab790270-ae9e-4244-9b94-fa7922dc254b"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }

}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    target_group_arn = aws_alb_target_group.this.arn
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

}