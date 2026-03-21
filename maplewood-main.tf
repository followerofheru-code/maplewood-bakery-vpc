# ─────────────────────────────────────────
# Maplewood Bakery — VPC Infrastructure
# Project 1 · Beginner
# ─────────────────────────────────────────

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ── PROVIDER ──────────────────────────────
provider "aws" {
  region = var.aws_region
}

# ── VPC ───────────────────────────────────
resource "aws_vpc" "maplewood_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "maplewood-vpc"
    Project = "Maplewood Bakery"
  }
}

# ── SUBNETS ───────────────────────────────
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.maplewood_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "maplewood-public-subnet"
    Project = "Maplewood Bakery"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.maplewood_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name    = "maplewood-private-subnet"
    Project = "Maplewood Bakery"
  }
}

# ── INTERNET GATEWAY ──────────────────────
resource "aws_internet_gateway" "maplewood_igw" {
  vpc_id = aws_vpc.maplewood_vpc.id

  tags = {
    Name    = "maplewood-igw"
    Project = "Maplewood Bakery"
  }
}

# ── ROUTE TABLES ──────────────────────────

# Public route table — has internet access
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.maplewood_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.maplewood_igw.id
  }

  tags = {
    Name    = "maplewood-public-rt"
    Project = "Maplewood Bakery"
  }
}

# Private route table — no internet route (intentional)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.maplewood_vpc.id

  tags = {
    Name    = "maplewood-private-rt"
    Project = "Maplewood Bakery"
  }
}

# ── ROUTE TABLE ASSOCIATIONS ──────────────
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

# ── SECURITY GROUP ────────────────────────
resource "aws_security_group" "web_sg" {
  name        = "maplewood-web-sg"
  description = "Allow HTTP, HTTPS, SSH for web server"
  vpc_id      = aws_vpc.maplewood_vpc.id

  # HTTP — public web traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  # HTTPS — secure web traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }

  # SSH — admin access restricted to your IP only
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
    description = "SSH admin access"
  }

  # Outbound — allow all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name    = "maplewood-web-sg"
    Project = "Maplewood Bakery"
  }
}
