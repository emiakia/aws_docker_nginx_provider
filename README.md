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
