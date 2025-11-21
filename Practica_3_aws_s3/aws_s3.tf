resource "aws_s3_bucket" "example" {
  count  = 3
  bucket = "bucket-djmp-terraform-${random_string.sufijo[count.index].id}"

  tags = {
    Name        = "My bucket from terraform"
    Environment = "Dev"
  }
}

resource "random_string" "sufijo" {
  count   = 3
  length  = 4
  special = false
  upper   = false
  numeric = false
}

# Crea un Security Group que permite el acceso SSH (puerto 22)
resource "aws_security_group" "ec2_sg" {
  name        = "ssh_access_sg"
  description = "Permite trafico SSH desde cualquier lugar"

  # Regla de entrada (Ingress) para SSH
  ingress {
    description = "Acceso SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # ¡ADVERTENCIA! 0.0.0.0/0 permite acceso desde todo internet. 
    # Para mayor seguridad, reemplaza esto con tu IP pública.
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla de salida (Egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Permite todo el tráfico saliente
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2-SG-Basico"
  }
}

# --- 2. CONFIGURACIÓN DE LA INSTANCIA EC2 ---

# Obtiene la última Amazon Machine Image (AMI) de Amazon Linux 2 (compatible con Free Tier)
data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name = "name"
    # Busca la AMI de Amazon Linux 2 para arquitecturas x86_64
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  owners = ["amazon"] # ID de cuenta de AWS de Amazon
}

# Crea la instancia EC2
resource "aws_instance" "basic_ec2" {
  # Utiliza la AMI encontrada arriba
  ami = data.aws_ami.amazon_linux.id
  # t2.micro está en el Nivel Gratuito (Free Tier)
  instance_type = "t2.micro"
  # Asigna el Security Group creado
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  tags = {
    Name        = "Free-Tier-EC2"
    Environment = "Dev"
  }
}

# --- 3. SALIDAS (Outputs) ---
# Muestra la IP pública para la conexión
output "public_ip" {
  description = "La IP pública de la instancia EC2"
  value       = aws_instance.basic_ec2.public_ip
}
