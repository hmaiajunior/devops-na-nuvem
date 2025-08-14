variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "tags" {
  type = object({
    Project    = string
    Enviroment = string
  })

  default = {
    Project = "nsse",
    Enviroment = "production"
  }
}

variable "vpc_zone_identifier" {
  type = list(string) 
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "instance_profile_name" {
  type = string
  
}

variable "key_name" {
  type = string
}

variable "image_id" {
  type = string
  
}

variable "launch_template" {
  type = object({
    name = string
    disable_api_stop = bool
    disable_api_termination = bool
    instance_type = string
    instance_initiated_shutdown_behavior = string
    ebs = object({
      size = number
      ebs_delete_on_termination = bool
    })
  })
}

variable "worker_launch_template" {
  type = object({
    name = string
    disable_api_stop = bool
    disable_api_termination = bool
    instance_type = string
    instance_initiated_shutdown_behavior = string
    ebs = object({
      size = number
      ebs_delete_on_termination = bool
    })
  })
  default = {
    name = "nsse-production-debian-worker-lt"
    disable_api_stop = true
    disable_api_termination = true
    instance_type = "t3.micro"
    instance_initiated_shutdown_behavior = "terminate"
    ebs = {
      size = 20
      ebs_delete_on_termination = true
    }
  }
}


variable "auto_scaling_group" {
  type = object({
    name = string
    max_size = number
    min_size = number
    desired_capacity = number
    health_check_grace_period = number
    health_check_type = string
    instance_maintenance_policy = object({
      min_healthy_percentage = number
      max_healthy_percentage = number
    })
  })
}

variable "worker_auto_scaling_group" {
  type = object({
    name = string
    max_size = number
    min_size = number
    desired_capacity = number
    health_check_grace_period = number
    health_check_type = string
    instance_maintenance_policy = object({
      min_healthy_percentage = number
      max_healthy_percentage = number
    })
  })
  default = {
    name = "nsse-production-worker-asg"
    max_size = 1
    min_size = 1
    desired_capacity = 1
    health_check_grace_period = 180
    health_check_type = "EC2"
    instance_maintenance_policy = {
      min_healthy_percentage = 100
      max_healthy_percentage = 110
    }
  }
}