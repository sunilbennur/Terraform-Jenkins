provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" # Replace with your desired VPC CIDR block
}

resource "aws_subnet" "public" {
  count             = 5
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index}.0/24" # Replace with your desired public subnet CIDR blocks
  availability_zone = "us-east-1a"               # Replace with your desired availability zone
}

resource "aws_instance" "example" {
  count         = 5
  ami           = "ami-053b0d53c279acc90" # Replace with your desired AMI ID
  instance_type = "t2.micro"              # Replace with your desired instance type
  subnet_id     = aws_subnet.public[count.index].id
  tags = {
    Name = "Instance-${count.index + 1}"  # Unique name for each instance
  }

}
