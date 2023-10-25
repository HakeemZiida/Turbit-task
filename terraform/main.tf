# Creating a new key pair
resource "aws_key_pair" "db_key_pair" {
  key_name   = "db-key"  # Name for the key pair
  public_key = var.public_key  # Path to public key file
}

resource "aws_instance" "primary_mongodb" {
  ami           = var.ami_id  
  instance_type = var.instance_type 
  key_name      = aws_key_pair.db_key_pair.key_name 
  vpc_security_group_ids = [aws_security_group.primary.id]
  tags = {
    Name = "Primary MongoDB"
  }
}

resource "aws_instance" "backup_mongodb" {
  ami           = var.ami_id  
  instance_type = var.instance_type  
  key_name      = aws_key_pair.db_key_pair.key_name 
  vpc_security_group_ids = [aws_security_group.backup.id]
  tags = {
    Name = "Backup MongoDB"
  }
}

resource "aws_security_group" "primary" {
  name        = "primary-mongodb"
  description = "Security group for primary MongoDB server"
  ingress {
    from_port   = 22  # SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # IP address for SSH access NB: SHOULD BE CHANGED TO ONLY ALLOWED IPs
  }
  # Allow MongoDB access
  ingress {
    from_port   = 27017  # MongoDB port
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # IP addresses that should have MongoDB access NB: SHOULD BE CHANGED TO ONLY ALLOWED IPs
  }
}

resource "aws_security_group" "backup" {
  name        = "backup-mongodb"
  description = "Security group for backup MongoDB server"
  ingress {
    from_port   = 22  # SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # IP address for SSH access NB: SHOULD BE CHANGED TO ONLY ALLOWED IPs
  }
}
