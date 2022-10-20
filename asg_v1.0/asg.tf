resource "aws_autoscaling_group" "main-asg" {
  name                      = format("%s-main-asg", var.env)
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 60
  health_check_type         = "EC2"
  desired_capacity          = var.desired_capacity
  force_delete              = var.force_delete
  launch_configuration      = aws_launch_configuration.main.name
  vpc_zone_identifier       = var.vpc_zone_identifier
instance_refresh {
  strategy = "Rolling"
  preferences {
    min_healthy_percentage = 50
  }
  lifecycle {
  create_before_destroy = true
}
}
}

