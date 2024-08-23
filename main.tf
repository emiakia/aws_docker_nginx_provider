provider "aws" {
  region = "eu-central-1" # Adjust to your preferred AWS region
}

# Define the security group
resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# Define the EC2 instance
resource "aws_instance" "web_server" {
  ami           = "ami-0de02246788e4a354" # Replace with your desired AMI
  instance_type = "t2.micro"
  key_name      = "devKey" # Ensure this key pair exists in your AWS region
  security_groups = [aws_security_group.web_sg.name]

  user_data = <<-EOF
<<<<<<< HEAD
                #!/bin/bash

                # Get playbook from Github
                wget https://raw.githubusercontent.com/emiakia/nginx_provider/main/playbook.yml

                # Define the path to your Ansible playbook
                PLAYBOOK_PATH="./playbook.yml"

                # Update the system
                echo "Updating system..."
                sudo yum update -y

                # Install Ansible
                echo "Installing Ansible..."
                sudo yum install -y ansible

                # Verify Ansible installation
                echo "Verifying Ansible installation..."
                ansible --version

                # Run the Ansible playbook
                echo "Running Ansible playbook..."
                ansible-playbook "$PLAYBOOK_PATH"
=======
              #!/bin/bash
              # Update the package index
              yum update -y

              # Install git and Docker
              yum install -y git docker

              # Start Docker service
              systemctl start docker
              systemctl enable docker

              # Clone the GitHub repository
              git clone https://github.com/emiakia/nginx_provider.git /home/ec2-user/nginx_provider

              # Run the install script
              chmod +x /home/ec2-user/nginx_provider/install_nginx_docker.sh
              /home/ec2-user/nginx_provider/install_nginx_docker.sh
>>>>>>> ec819e9 (Initialize)
              EOF

  tags = {
    Name = "web-server-instance"
  }
}

# Output the public IP of the instance
output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}
