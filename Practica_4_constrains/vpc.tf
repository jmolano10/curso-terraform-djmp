resource "aws_vpc" "vpc_djmp_virginia" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "VPC_DJMP_VIRGINIA"
    Env  = "dev"
  }
}

resource "aws_vpc" "vpc_djmp_ohio" {
  cidr_block = "10.20.0.0/16"
  tags = {
    Name = "VPC_DJMP_OHIO"
    Env  = "dev"
  }
  provider = aws.ohio
}
