resource "aws_security_group" "filedgr-ipfs-sg-private" {
  vpc_id = var.vpcId
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 4001
    protocol    = "udp"
    to_port     = 4001
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 4001
    protocol    = "tcp"
    to_port     = 4001
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5001
    protocol    = "tcp"
    to_port     = 5001
    cidr_blocks = ["0.0.0.0/0"]
  }
  #  Can we make this conditional if we want a gateway or not?
  ingress {
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
}
