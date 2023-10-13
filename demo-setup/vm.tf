resource "aws_instance" "skuppervm" {
  ami           = "ami-0c41531b8d18cc72b"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.skuppervm.key_name
  subnet_id     = aws_subnet.main.id

  tags = {
    Name = "SkupperVM"
  }
}

resource "aws_key_pair" "skuppervm" {
  key_name   = "skupper vm"
  public_key = tls_private_key.skuppervm.public_key_openssh
}

resource "tls_private_key" "skuppervm" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Main"
  }
}