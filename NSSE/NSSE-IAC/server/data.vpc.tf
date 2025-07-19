#data "aws_vpc" "this" {
#  filter {
#    name  = "tag:Name"
#    values = [var.vpc_resources.vpc]
#  }
#}

data "aws_vpc" "this" {
    default = true
}