resource "aws_vpc" "nsse_production_vpc" {

  cidr_block = "10.0.0.0/24"
  tags       = merge({ Name = "nsse-production-vpc" }, var.tags)

}