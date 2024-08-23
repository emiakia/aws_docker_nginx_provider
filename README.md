<<<<<<< HEAD
# NGINX Provider Setup

This project provides a complete solution for deploying an NGINX web server on an EC2 instance. The setup involves:

1. Creating an EC2 instance.
2. Installing Ansible on the EC2 instance.
3. Retrieving an Ansible playbook from a GitHub repository.
4. Running the Ansible playbook to:
   - Install Docker.
   - Deploy an NGINX container.
   - Serve a custom `index.html` file that displays the local IP address.

## Getting Started

### Prerequisites

- AWS CLI configured with appropriate credentials.
- Terraform installed (if using Terraform to provision the EC2 instance).
- Access to the GitHub repository containing the Ansible playbook.

### Usage

1. **Configure Your Terraform (or Other Provisioning Tool) Files**

   Update your Terraform (or other provisioning tool) configuration to provision an EC2 instance. Ensure that the instance has permissions to install software and run commands.

2. **Provision the EC2 Instance**

   Run Terraform (or your chosen tool) to create the EC2 instance. For example, using Terraform:

   ```sh
   terraform init
   terraform apply
=======
# AWS Infrastructure with Terraform

This Terraform project provisions an AWS infrastructure that includes EC2 instances, security groups, an Application Load Balancer (ALB), a target group, and necessary listener configurations. The setup includes an auto-scaling group to ensure high availability and scalability of your web servers.

## Overview

The project automates the deployment of a scalable and secure web application infrastructure on AWS. It provisions:

- **Security Groups**: For the ALB and EC2 instances.
- **Launch Template**: Configures the EC2 instances with the necessary settings and user data.
- **Auto Scaling Group**: Ensures that the right number of EC2 instances are running based on demand.
- **Application Load Balancer (ALB)**: Distributes incoming traffic across the EC2 instances.
- **Target Group**: Routes traffic from the ALB to the EC2 instances.
- **Listener**: Configures how the ALB handles incoming requests.

## Project Structure

- **`main.tf`**: The main entry point for the Terraform configuration, which orchestrates the use of all modules.
- **`variables.tf`**: Contains the variable declarations used throughout the project.
- **`terraform.tfvars`**: Defines the values for the variables used in the project.
- **`output.tf`**: Specifies the outputs of the Terraform configuration.
- **`locals.tf`**: Defines local values used in the Terraform configuration.
- **`modules/`**: Contains all the Terraform modules used in this project.
  - **`security_group/`**: Defines the security group configuration.
  - **`launch_template/`**: Handles the provisioning of EC2 instances.
  - **`autoscaling_group/`**: Manages the auto-scaling group configuration.
  - **`alb/`**: Sets up the Application Load Balancer (ALB).
  - **`lb_target_group/`**: Manages the creation of a target group for the ALB.
  - **`lb_listener/`**: Configures the ALB listener.

## Usage

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/terraform-asg-alb.git
cd terraform-asg-alb
>>>>>>> a4cfcdc (ALB ASG Launch instance with Nginx completly modular)
