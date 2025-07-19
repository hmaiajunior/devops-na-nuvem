resource "aws_security_group" "allow_ssh" {
  name        = var.ec2_resources.ssh_security_group
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.this.id


ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ec2_resources.ssh_source_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
   
tags = merge(var.tags, {
  Name = var.ec2_resources.ssh_security_group
})
}