DevOps Automation Project: Terraform + Ansible + Monitoring Stack
Project Overview
This project demonstrates the deployment and configuration of a complete DevOps stack using Terraform, Ansible, Prometheus, and Grafana. The goal is to automate infrastructure provisioning, application deployment, database setup, and monitoring on an Ubuntu EC2 instance.
Key components:
Terraform: Provision EC2 instances in a VPC with public/private subnets, NAT gateway, security groups, and environment-specific configurations (dev/prod).
Ansible: Automate installation and configuration of Nginx, MySQL, PostgreSQL, and Docker Swarm. Includes user creation and seeding sample data.
Prometheus: Collect metrics from PostgreSQL, MySQL, and system metrics.
Grafana: Visualize metrics in dashboards.
Project Structure
Copy code

DevOps-task/
├── terraform/                     # Terraform code for EC2 and VPC
│   ├── main.tf
│   ├── variables.tf
│   ├── dev.tfvars
│   ├── prod.tfvars
│   └── outputs.tf
├── ansible/                       # Ansible playbooks
│   ├── hosts.ini
│   ├── site.yml
│   ├── roles/
│   │   ├── nginx/
│   │   ├── mysql/
│   │   ├── postgresql/
│   │   ├── docker_swarm/
│   │   ├── monitoring/
│   │   └── logrotate/
└── README.md                       # Project documentation
Prerequisites
Ubuntu 24.04+ machine as Ansible controller
AWS account with IAM permissions
Installed tools on controller:
Terraform
Ansible
AWS CLI configured
Access to EC2 key pair
Terraform: Infrastructure Setup
Navigate to the terraform folder:
Bash
Copy code
cd terraform
Initialize Terraform:
Bash
Copy code
terraform init
Apply Terraform for dev environment:
Bash
Copy code
terraform apply -var-file="dev.tfvars" -auto-approve
Apply Terraform for prod environment:
Bash
Copy code
terraform apply -var-file="prod.tfvars" -auto-approve
This will create:
VPC with public/private subnets
NAT gateway for outbound internet
Security groups with SSH/HTTP/Custom ports
EC2 instance with key pair
Ansible: Application Deployment
Update hosts.ini with your EC2 public IP and SSH user.
Run the playbook:
Bash
Copy code
cd ansible
ansible-playbook -i hosts.ini site.yml
What this playbook does:
Installs and starts Nginx
Installs MySQL & PostgreSQL, creates users and databases, seeds sample data
Installs Docker and initializes Docker Swarm
Installs Prometheus & Grafana
Configures log rotation for MySQL/PostgreSQL
Prometheus Setup
Prometheus is installed on EC2 and runs as a systemd service.
Configuration files are located at:
Copy code

/etc/prometheus/prometheus.yml
/var/lib/prometheus
Prometheus collects:
PostgreSQL metrics
MySQL metrics
System metrics (CPU, Memory, Disk)
Access Prometheus UI:
Copy code

http://<EC2_PUBLIC_IP>:9090
Grafana Setup
Grafana is installed and runs as a systemd service.
Bind Grafana to all interfaces (http_addr = 0.0.0.0) in /etc/grafana/grafana.ini.
Access Grafana UI:
Copy code

http://<EC2_PUBLIC_IP>:3000
Add PostgreSQL/MySQL as data sources. Use credentials from the Ansible playbook:
YAML
Copy code
login_user: postgres
login_password: PgRoot@123!
Create dashboards to visualize:
Database metrics
System metrics
Docker Swarm metrics
Log Rotation
Log rotation ensures logs do not consume all disk space.
Configured for MySQL/PostgreSQL via Ansible using logrotate.
Configuration directory:
Copy code

/etc/logrotate.d/
Test log rotation:
Bash
Copy code
sudo logrotate -d /etc/logrotate.d/mysql
sudo logrotate -d /etc/logrotate.d/postgresql
Troubleshooting
Prometheus not accessible: Check service status:
Bash
Copy code
sudo systemctl status prometheus
Grafana not accessible: Check firewall/security groups for port 3000.
Database connection errors: Verify user credentials in the Ansible playbook.
References
Terraform Documentation⁠�
Ansible Documentation⁠�
Prometheus Documentation⁠�
Grafana Documentation⁠�
