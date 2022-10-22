resource "aws_security_group" "main" {
  name        = format("%s-main-sg", var.env)
  description = "this is a security group for web instance"
}

resource "aws_security_group_rule" "web_ingress" {
  count = length(var.web_ports)
  type              = "ingress"
  from_port         = element(var.web_ports, count.index)
  to_port           = element(var.web_ports, count.index)
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
}

resource "aws_security_group_rule" "web_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
}
