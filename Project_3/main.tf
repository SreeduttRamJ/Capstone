provider "aws" {

  region = var.region

}



resource "aws_vpc" "main" {

  cidr_block = "10.0.0.0/16"

  tags = {

    Name = "project01-vpc"

  }

}



resource "aws_subnet" "public" {

  vpc_id                  = aws_vpc.main.id

  cidr_block              = "10.0.1.0/24"

  map_public_ip_on_launch = true

  tags = {

    Name = "project01-public-subnet"

  }

}



resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

}



resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id



  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id

  }

}



resource "aws_route_table_association" "assoc" {

  subnet_id      = aws_subnet.public.id

  route_table_id = aws_route_table.public.id

}





resource "aws_security_group" "web_sg" {

  vpc_id = aws_vpc.main.id



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

}



resource "aws_instance" "web" {

  ami                    = var.ami_id

  instance_type          = var.instance_type

  subnet_id              = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data              = file("user-data.sh")



  tags = {

    Name        = "project01-web-server"

    Enviornment = "dev"

    Owner       = "devinfra"

  }

}



resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {

  alarm_name          = "HighCPUAlarm"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods  = 2

  metric_name         = "CPUUtilization"

  namespace           = "AWS/EC2"

  period              = 60

  statistic           = "Average"

  threshold           = var.cpu_threshold

  alarm_description   = "Triggers when CPU is above threshold"



  dimensions = {

    InstanceId = aws_instance.web.id

  }



  treat_missing_data = "notBreaching"

}


