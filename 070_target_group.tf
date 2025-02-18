resource "aws_lb_target_group" "this" {
  name        = "${var.environment}-shahbaz-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.shahbaz_vpc.id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

}

resource "aws_lb_target_group_attachment" "this" {
  count            = 2
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.web[count.index].id
  port             = 80

}
