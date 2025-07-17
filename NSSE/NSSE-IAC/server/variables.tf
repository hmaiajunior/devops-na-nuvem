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

variable "ec2_resources" {
  type = object({
    key_pair_name = string
    instance_role = string
    instance_profile = string
  })

    default = {
        key_pair_name = "nsse-produciton-key-pair"
        instance_role = "nsse-production-instance-role"
        instance_profile = "nsse-production-instance-profile"
    }
}

