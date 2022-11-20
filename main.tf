# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "vpc"
  }
}

# Creates Subnet - 1
resource "aws_subnet" "subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"
  tags = {
    "Name" = "subnet-1"
  }
}

# Creates Subnet - 2
resource "aws_subnet" "subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"
  tags = {
    "Name" = "subnet-2"
  }
}

# Creates Internet Gateway
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "ig"
  }
}

# Creates Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    "Name" = "rt"
  }
}

# Creates Route Association for Subnet - 1
resource "aws_route_table_association" "rt-asoc-1a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.rt.id
}

# Creates Route Association for Subnet - 2
resource "aws_route_table_association" "rt-asoc-1b" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.rt.id
}

# Creates EC2 instance in AZ - 1a
resource "aws_instance" "instance-1" {
  ami           = var.instance_name
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet-1.id
  tags = {
    "Name" = "instance-1"
  }
}

# Creates EC2 instance in AZ - 1b
resource "aws_instance" "instance-2" {
  ami           = var.instance_name
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet-2.id
  tags = {
    "Name" = "instance-2"
  }
}
