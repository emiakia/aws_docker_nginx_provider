provider "aws" {
  region = "eu-central-1"
}

# Create Security Group for ALB
module "alb_security_group" {
  source = "./modules/security_group"
  # sg_name_prefix   = var.alb_name_prefix
  sg_name          = var.alb_sg_name
  sg_description   = var.alb_sg_description
  sg_vpc_id        = var.alb_sg_vpc_id
  sg_ingress_rules = var.alb_sg_ingress_rules
  sg_egress_rules  = var.alb_sg_egress_rule
  sg_tags          = var.alb_sg_tags
}


# Create Security Group for EC2 Instances
module "ec2_security_group" {
  source = "./modules/security_group"
  # sg_name_prefix   = var.ec2_name_prefix
  sg_name          = var.ec2_sg_name
  sg_description   = var.ec2_sg_description
  sg_vpc_id        = var.ec2_sg_vpc_id
  sg_ingress_rules = var.ec2_sg_ingress_rules
  sg_egress_rules  = var.ec2_sg_egress_rule
  sg_tags          = var.ec2_sg_tags
}

# Launch Template
module "web_server_lt" {
  source              = "./modules/launch_template"
  wslt_name_prefix    = var.wslt_name_prefix
  wslt_image_id       = var.wslt_image_id
  wslt_instance_type  = var.wslt_instance_type
  wslt_key_name       = var.wslt_key_name
  wslt_user_data      = base64encode(var.wslt_user_data)
  wslt_security_group = [module.ec2_security_group.id]
  wslt_tags           = var.wslt_tags
}

# Auto Scaling Group
module "web_asg" {
  source                        = "./modules/autoscaling_group"
  asg_desired_capacity          = var.asg_desired_capacity
  asg_max_size                  = var.asg_max_size
  asg_min_size                  = var.asg_min_size
  asg_vpc_zone_identifier       = var.asg_vpc_zone_identifier
  asg_launch_template_id        = module.web_server_lt.id
  asg_launch_template_version   = "$Latest"
  asg_tag_name                  = "web-server-instance"
  asg_health_check_type         = var.asg_health_check_type
  asg_health_check_grace_period = var.asg_health_check_grace_period
  asg_target_group_arns         = [module.web_tg.tg_arn]
}

# Application Load Balancer
module "alb" {
  source                         = "./modules/alb"
  alb_name                       = var.alb_name
  alb_internal                   = var.alb_internal
  alb_load_balancer_type         = var.alb_load_balancer_type
  alb_security_groups            = [module.alb_security_group.id]
  alb_subnets                    = var.alb_subnets
  alb_enable_deletion_protection = var.alb_enable_deletion_protection
  alb_tags                       = var.alb_tags
}

# Target Group for the ALB
module "web_tg" {
  source        = "./modules/lb_target_group"
  lbtg_name     = var.lbtg_name
  lbtg_port     = var.lbtg_port
  lbtg_protocol = var.lbtg_protocol
  lbtg_vpc_id   = var.vpc_id

  lbtg_health_check_path     = var.lbtg_health_check_path
  lbtg_health_check_protocol = var.lbtg_health_check_protocol
  lbtg_health_check_matcher  = var.lbtg_health_check_matcher
  lbtg_health_check_interval = var.lbtg_health_check_interval
  lbtg_health_check_timeout  = var.lbtg_health_check_timeout
  lbtg_healthy_threshold     = var.lbtg_healthy_threshold
  lbtg_unhealthy_threshold   = var.lbtg_unhealthy_threshold

  lbtg_tags = var.lbtg_tags
}

# Listener for the ALB
module "web_listener" {
  source                  = "./modules/lb_listener"
  lblst_load_balancer_arn = module.alb.alb_arn

  lblst_port     = var.lblst_port
  lblst_protocol = var.lblst_protocol

  lblst_default_action_type             = var.lblst_default_action_type
  lblst_default_action_target_group_arn = module.web_tg.tg_arn
}

