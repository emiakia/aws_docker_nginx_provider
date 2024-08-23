
# output "ec2_instance_dns" {
#   value = module.ec2.public_dns
# }

# output "ec2_instance_id" {
#   value = module.ec2.instance_id
# }

# output "ec2_public_ip" {
#   value = module.ec2.public_ip
# }

# output "id" {
#   value = module.security_group.id
# }

# output "alb_dns_name" {
#   value       = module.alb.lb_dns_name
#   description = "The DNS name of the Application Load Balancer"
# }
output "security_group_id" {
  value = module.ec2_security_group.id
}
##################################
output "web_server_lt_id" {
  value = module.web_server_lt.id
}
#######################
output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}
output "alb_arn" {
  description = "The ARN of the Load Balancer"
  value       = module.alb.alb_arn
}
#######################
output "web_asg_id" {
  value = module.web_asg.asg_id
}