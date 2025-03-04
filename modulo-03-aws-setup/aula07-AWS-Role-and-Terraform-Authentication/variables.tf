variable "region" {
  type    = string
  default = "us-east-1"
}

variable "assume_role" {
  type = object({
    role_arn    = string
    external_id = string

  })

  default = {
    role_arn    = "arn:aws:iam::513794908995:role/terraform-role"
    external_id = "b5b2884c-fe2f-4b26-83e4-626d110c46e0"

  }
}