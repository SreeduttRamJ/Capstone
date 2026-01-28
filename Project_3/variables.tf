variable "region" {

  default = "ap-south-1"

}



variable "instance_type" {

  default = "t3.micro"

}



variable "ami_id" {

  description = "Amazon Linux 2 AMI ID"

  default     = "ami-0ff5003538b60d5ec"


}



variable "cpu_threshold" {

  default = 70

}


