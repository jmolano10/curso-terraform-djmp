# Crea la instancia EC2
resource "aws_instance" "public_instance" {
  ami           = "ami-0fa3fe0fa7920f68e"
  instance_type = "t2.micro"
  tags = {
    Name        = "Free-Tier-EC2"
    Environment = "Dev"
  }
}
