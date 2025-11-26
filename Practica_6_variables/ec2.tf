# Crea la instancia EC2
resource "aws_instance" "public_instance" {
  ami           = "ami-0bfe853bc6518ddd4"
  instance_type = "t2.micro"
  tags = {
    Name        = "Windows Server 2026"
    Environment = "Dev"
  }
}
