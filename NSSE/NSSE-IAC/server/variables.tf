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
    ssh_security_group = string
    ssh_source_ip = string
  })

    default = {
        key_pair_name = "nsse-produciton-key-pair"
        instance_role = "nsse-production-instance-role"
        instance_profile = "nsse-production-instance-profile"
        ssh_security_group = "allow-ssh"
        ssh_source_ip = "177.37.155.67/32"    
        }
}


variable "control_plane_launch_template" {
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
    name = "nsse-production-debian-control-plane-lt"
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

variable "vpc_resources" {
  type = object({
    vpc = string
  })

  default = {
    vpc = "nsse-production-vpc"
  }
}

variable "control_plane_autoscaling_group" {
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
    name = "nsse-production-control-plane-asg"
    max_size = 1
    min_size = 1
    desired_capacity = 1
    health_check_grace_period = 180
    health_check_type = "EC2"
    instance_maintenance_policy = {
      min_healthy_percentage = 100
      max_healthy_percentage = 120
    }
  }
  
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
