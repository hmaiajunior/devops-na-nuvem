resource "aws_internet_gateway" "nsse_production_vpc_internet_gateway" {

  vpc_id = aws_vpc.this.id
  tags   = merge({ Name = "nsse-production-vpc-internet-gateway" }, var.tags)

}