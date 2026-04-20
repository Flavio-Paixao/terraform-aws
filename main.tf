# AMI Ubuntu 22.04
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# Security Group
resource "aws_security_group" "api_sg" {
  name        = "${var.project_name}-sg"
  description = "Security Group para API de Tarefas"

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

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
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
    Name    = "${var.project_name}-sg"
    Project = var.project_name
  }
}

# Instância EC2

# Chave SSH
   resource "aws_key_pair" "terraform_key" {
   key_name   = "terraform-key"
   public_key = file("~/.ssh/terraform-key.pub")
}
resource "aws_instance" "api_server" {
    ami                    = data.aws_ami.ubuntu.id
    instance_type          = var.instance_type
    vpc_security_group_ids = [aws_security_group.api_sg.id]
    key_name               = aws_key_pair.terraform_key.key_name

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y python3-pip python3-venv git
    cd /home/ubuntu
    git clone https://github.com/Flavio-Paixao/api-aws.git
    cd api-aws
    python3 -m venv venv
    source venv/bin/activate
    pip install django djangorestframework gunicorn drf-spectacular tzdata
    sed -i "s/ALLOWED_HOSTS = \['15.229.17.21', 'localhost'\]/ALLOWED_HOSTS = ['54.232.211.241', 'localhost']/" config/settings.py
    python manage.py migrate
    gunicorn --workers 3 --bind 0.0.0.0:8000 config.wsgi:application --daemon
  EOF

  tags = {
    Name    = "${var.project_name}-server"
    Project = var.project_name
  }
}

# Elastic IP
resource "aws_eip" "api_eip" {
  instance = aws_instance.api_server.id
  domain   = "vpc"

  tags = {
    Name    = "${var.project_name}-eip"
    Project = var.project_name
  }
}