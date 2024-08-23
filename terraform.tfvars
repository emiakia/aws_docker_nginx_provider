
# create_sg = false
create_sg      = true
count_instance = 2
# AWS Provider Configuration
region = "eu-central-1"
# region = "us-east-1"


# Application Load balancer Security Group Variables
# alb_name_prefix = "alb-sg"
alb_sg_name        = "SG_HTTP"
alb_sg_description = "Allow SSH and HTTP inbound traffic"
alb_sg_vpc_id      = "vpc-0cc7e1e8d0e236d78"

alb_sg_ingress_rules = [
  {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
alb_sg_egress_rule = [
  {
    description = "All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
alb_sg_tags = {
  "Pupose" = "Just For Test By Terraform"
  "Name"   = "my-security-group"
}


# EC2 Security Group Variables
# ec2_name_prefix = "ec2-sg"

ec2_sg_name        = "SG_HTTP_SSH"
ec2_sg_description = "Allow SSH and HTTP inbound traffic"
ec2_sg_vpc_id      = "vpc-0cc7e1e8d0e236d78"

ec2_sg_ingress_rules = [
  {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
ec2_sg_egress_rule = [
  {
    description = "All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
ec2_sg_tags = {
  "Pupose" = "Just For Test By Terraform"
  "Name"   = "my-security-group"
}


##################################################
#Variable of launch template
wslt_name_prefix = "web-server-"
wslt_image_id    = "ami-0de02246788e4a354"
# wslt_instance_type = "t2.micro"
wslt_key_name  = "devKey"
wslt_user_data = <<-EOF
              #!/bin/bash
              # Update the package index
              yum update -y

              # Install git and Docker
              yum install -y git docker

              # Start Docker service
              systemctl start docker
              systemctl enable docker

              # Clone the GitHub repository
              # git clone https://github.com/emiakia/terraform-alb-asg-nginx.git /home/ec2-user/nginx_provider
              wget -O /home/ec2-user/nginx_provider/install_nginx_docker.sh https://raw.githubusercontent.com/emiakia/terraform-alb-asg-nginx/main/install_nginx_docker.sh

              # Run the install script
              chmod +x /home/ec2-user/nginx_provider/install_nginx_docker.sh
              /home/ec2-user/nginx_provider/install_nginx_docker.sh
              EOF

# wslt_create_before_destroy = true

wslt_tags = {
  Name = "Web Server Launch Template"
}
##################################################
#AutoScaling Group Variables
asg_vpc_zone_identifier = ["subnet-0a21b416cfd5ab2a3", "subnet-093f0311edbfe83fb", "subnet-04f0df809d5307602"]
# asg_desired_capacity = 2
# asg_max_size = 3
# asg_min_size = 1
# asg_health_check_type = "EC2"
# asg_health_check_grace_period = 300
##################################################
#aws Instance Variables

ami_id        = "ami-071878317c449ae48"
instance_type = "t2.micro"
key_name      = "devKey"

machine_name = "Emran"
# subnets      = ["subnet-093f0311edbfe83fb", "subnet-0a21b416cfd5ab2a3", "subnet-04f0df809d5307602"]
default_sg = "sg-0a28a74fed00b7df4"

backend-bucket = "dev-terraform-tutorial"
backend-key    = "build/airflow/terraform.tfstate"
created_by     = "Terraform"
user_data      = <<-EOF
            #!/bin/bash
            yum update -y
            yum install -y httpd
            systemctl start httpd
            systemctl enable httpd
            echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
            EOF

####################################################
####################################################
#Application Load balancer Variables 
alb_name                       = "web-lb"
alb_internal                   = false
alb_load_balancer_type         = "application"
alb_enable_deletion_protection = false
alb_subnets                    = ["subnet-0a21b416cfd5ab2a3", "subnet-093f0311edbfe83fb", "subnet-04f0df809d5307602"]
alb_tags = {
  "Pupose" = "Test By Terraform For ALB"
}

####################################################
####################################################
#Application Load Balancer Target Group
lbtg_name     = "web-tg"
lbtg_port     = 80
lbtg_protocol = "HTTP"
lbtg_tags = {
  "Pupose" = "Test By Terraform For ALB"
}
lbtg_health_check_path     = "/"
lbtg_health_check_protocol = "HTTP"
lbtg_health_check_matcher  = "200"
lbtg_health_check_interval = 30
lbtg_health_check_timeout  = 5
lbtg_healthy_threshold     = 3
lbtg_unhealthy_threshold   = 2

#Load balancer Listener variables
# lblst_load_balancer_arn = 
lblst_port     = 80
lblst_protocol = "HTTP"
#default_action
lblst_default_action_type = "forward"
# lblst_default_action_target_group_arn = 


#Load balancer target group attachment
lbtgatt_port = 80