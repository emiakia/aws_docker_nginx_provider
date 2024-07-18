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

Additionally, once the EC2 instances are launched, the project automatically installs Ansible, retrieves a playbook from GitHub, and uses it to install Docker and run an NGINX container with a custom `index.html` file.

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

## Additional Functionality

### Automated Deployment

After provisioning the EC2 instances, the following steps are performed:

1. **Install Ansible**: Ansible is installed on the EC2 instances.
2. **Fetch Playbook from GitHub**: The playbook, which is part of the project's files, is retrieved from a GitHub repository.
3. **Install Docker**: Docker is installed on the EC2 instances.
4. **Run NGINX Container**: An NGINX Docker container is started. The container serves a custom `index.html` file that includes the local IP address of the EC2 instance.

### Playbook Details

The playbook, located in the project's files, automates the following tasks:

- **Docker Installation**: Installs Docker on the EC2 instance.
- **Index.html Creation**: Generates an `index.html` file with the local IP address.
- **NGINX Container Deployment**: Runs an NGINX Docker container with the custom HTML file.

## Usage

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/terraform-asg-alb.git
cd terraform-asg-alb
