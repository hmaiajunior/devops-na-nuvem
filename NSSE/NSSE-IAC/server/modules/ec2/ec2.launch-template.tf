resource "aws_launch_template" "this" {
  name = var.control_plane_launch_template.name
  disable_api_stop        = var.control_plane_launch_template.disable_api_stop
  disable_api_termination = var.control_plane_launch_template.disable_api_termination
  instance_type = var.control_plane_launch_template.instance_type
  #key_name = aws_key_pair.this.key_name
  key_name = var.key_name
  # image_id = data.aws_ami.this.image_id
  image_id = var.image_id
  instance_initiated_shutdown_behavior = var.control_plane_launch_template.instance_initiated_shutdown_behavior
  #vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  vpc_security_group_ids = var.vpc_security_group_ids

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = var.control_plane_launch_template.ebs.size
      delete_on_termination = var.control_plane_launch_template.ebs.ebs_delete_on_termination
   }
  }



  iam_instance_profile {
    #name = "aws_iam_instance_profile.control_plane.name"
    name = var.instance_profile_name
  }

  instance_market_options {
    market_type = "spot"
  }

  tag_specifications {
    resource_type = "instance"
    tags = var.tags
  }
}