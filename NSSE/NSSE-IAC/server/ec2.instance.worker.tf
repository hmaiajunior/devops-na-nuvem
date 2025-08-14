module "ec2_workers_instances" {
  source = "./modules/ec2"
  key_name = aws_key_pair.this.key_name
  instance_profile_name = aws_iam_instance_profile.instance_profile.name
  vpc_zone_identifier = data.aws_subnets.private_subnets.ids
  image_id = data.aws_ami.this.image_id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  launch_template = {
    name = var.worker_launch_template.name
    disable_api_stop = var.worker_launch_template.disable_api_stop
    disable_api_termination = var.worker_launch_template.disable_api_termination
    instance_type = var.worker_launch_template.instance_type
    instance_initiated_shutdown_behavior = var.worker_launch_template.instance_initiated_shutdown_behavior
    ebs = {
      size = var.worker_launch_template.ebs.size
      ebs_delete_on_termination = var.worker_launch_template.ebs.ebs_delete_on_termination
    }
  }
  auto_scaling_group = {
    name = var.control_plane_autoscaling_group.name
    min_size = var.control_plane_autoscaling_group.min_size
    max_size = var.control_plane_autoscaling_group.max_size
    desired_capacity = var.control_plane_autoscaling_group.desired_capacity
    health_check_type = var.control_plane_autoscaling_group.health_check_type
    health_check_grace_period = var.control_plane_autoscaling_group.health_check_grace_period
    instance_maintenance_policy = {
        min_healthy_percentage = var.control_plane_autoscaling_group.instance_maintenance_policy.min_healthy_percentage
        max_healthy_percentage = var.control_plane_autoscaling_group.instance_maintenance_policy.max_healthy_percentage
    }
  }
  tags = var.tags
}