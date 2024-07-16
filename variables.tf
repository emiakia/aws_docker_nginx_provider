variable "create_sg" {}

# variable "count_instance" {}


#EC2 Variables
variable "ami_id" {}

variable "region" {}

variable "instance_type" {}
variable "key_name" {}
variable "machine_name" {}
variable "backend-bucket" {}
variable "backend-key" {}
variable "vpc_id" { default = "vpc-0cc7e1e8d0e236d78" }
variable "default_sg" {}
variable "created_by" {}
variable "user_data" {}

# variable "tags" {
#   type = map(string)
# }
variable "count_instance" {
  description = "Number of EC2 instances to create"
  type        = number
}


#ALB Security Group variables
# variable "alb_name_prefix" {}
variable "alb_sg_name" {}
variable "alb_sg_description" {}
variable "alb_sg_vpc_id" {}
variable "alb_sg_ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))


}
variable "alb_sg_egress_rule" {
  description = "List of egress rule"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "alb_sg_tags" {}
#################################################
#EC2 Security Group variables
# variable "ec2_name_prefix" {}
variable "ec2_sg_name" {}
variable "ec2_sg_description" {}
variable "ec2_sg_vpc_id" {}
variable "ec2_sg_ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))


}
variable "ec2_sg_egress_rule" {
  description = "List of egress rule"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "ec2_sg_tags" {}
#################################################

#Variable of launch template
variable "wslt_name_prefix" {}
variable "wslt_image_id" {}
variable "wslt_instance_type" { default = "t2.micro" }
variable "wslt_key_name" {}
variable "wslt_user_data" {}
# variable "wslt_create_before_destroy" {}
variable "wslt_tags" {}

#################################################
#Variables of autscaling group

variable "asg_desired_capacity" {
  type        = number
  default     = 2
  description = "Desired capacity of the Auto Scaling group."
}

variable "asg_max_size" {
  type        = number
  default     = 3
  description = "Maximum size of the Auto Scaling group."
}

variable "asg_min_size" {
  type        = number
  default     = 1
  description = "Minimum size of the Auto Scaling group."
}

variable "asg_vpc_zone_identifier" {
  type        = list(string)
  description = "A list of VPC subnet IDs."
}

variable "asg_health_check_type" {
  type        = string
  default     = "EC2"
  description = "Health check type for the Auto Scaling group."
}

variable "asg_health_check_grace_period" {
  type        = number
  default     = 300
  description = "Health check grace period for the Auto Scaling group."
}
#################################################
#################################################
#Variable of Application Load Balancer
variable "alb_name" {}
variable "alb_internal" {}
variable "alb_load_balancer_type" {}
variable "alb_subnets" {
  type = list(string)
}
variable "alb_enable_deletion_protection" {}
variable "alb_tags" {}

#################################################
#################################################



#Application Load Balancer Target Group
variable "lbtg_name" {}
variable "lbtg_port" {}
variable "lbtg_protocol" {}
# variable "lbtg_vpc_id" {}
variable "lbtg_tags" {}
#health_check
variable "lbtg_health_check_path" {}
variable "lbtg_health_check_protocol" {}
variable "lbtg_health_check_matcher" {}
variable "lbtg_health_check_interval" {}
variable "lbtg_health_check_timeout" {}
variable "lbtg_healthy_threshold" {}
variable "lbtg_unhealthy_threshold" {}

#Load balancer Listener variables
# variable "lblst_load_balancer_arn" {}
variable "lblst_port" {}
variable "lblst_protocol" {}
#default_action
variable "lblst_default_action_type" {}
# variable "lblst_default_action_target_group_arn" {}



#Load balancer target group attachment
variable "lbtgatt_port" {}