resource "aws_vpc" "vpc_djmp_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    Name = "VPC_DJMP_VIRGINIA"
    Env  = "dev"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_djmp_virginia.id
  cidr_block              = var.public_subnet
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_djmp_virginia.id
  cidr_block = var.private_subnet
}
