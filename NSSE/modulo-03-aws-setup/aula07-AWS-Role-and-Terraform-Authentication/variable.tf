variable "region" {
  type    = string
  default = "us-east-1"
}

variable "tags" {
  type = object({
    Project    = string
    Enviroment = string

  })
  default = {
    Project    = "nsse",
    Enviroment = "production"

  }

}

variable "assume_role" {
  type = object({
    role_arn    = string
    external_id = string

  })

  default = {
    role_arn    = "arn:aws:iam::353203138858:role/devopsnanuvem-week"
    external_id = "97b9dcb3-26e7-4798-830d-79f3dd893374"

  }
}

variable "public_subnets" {
  type = list(object({
    name                     = string
    cidr_block               = string
    availability_zone        = string
    map_public_ip_on_launch  = bool

  }))

default = [
   {
    name                     = "nsse-production-vpc-public-subnet-1a"
    cidr_block               = "10.0.0.0/27"
    availability_zone        = "us-east-1a"
    map_public_ip_on_launch  = true

   },
   {
    name                     = "nsse-production-vpc-public-subnet-1b"
    cidr_block               = "10.0.0.64/27"
    availability_zone        = "us-east-1b"
    map_public_ip_on_launch  = true
   }
  ]
}

variable "private_subnets" {
  type = list(object({
    name                     = string
    cidr_block               = string
    availability_zone        = string
    map_public_ip_on_launch  = bool

  }))

default = [
   {
    name                     = "nsse-production-vpc-private-subnet-1a"
    cidr_block               = "10.0.0.32/27"
    availability_zone        = "us-east-1a"
    map_public_ip_on_launch  = false

   },
   {
    name                     = "nsse-production-vpc-private-subnet-1b"
    cidr_block               = "10.0.0.96/27"
    availability_zone        = "us-east-1b"
    map_public_ip_on_launch  = false
   }
  ]
}