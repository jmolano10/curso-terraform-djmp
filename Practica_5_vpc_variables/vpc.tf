resource "aws_vpc" "vpc_djmp_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    Name = "VPC_DJMP_VIRGINIA"
    Env  = "dev"
  }
}

resource "aws_vpc" "vpc_djmp_ohio" {
  cidr_block = var.ohio_cidr
  tags = {
    Name = "VPC_DJMP_OHIO"
    Env  = "dev"
  }
  provider = aws.ohio
}
