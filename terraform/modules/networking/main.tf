# ══════════════════════════════════════════════════════════
# WHAT:      Creates the base network infrastructure: VPC, Subnets, Internet Gateway, and Route Tables.
# WHY:       Isolates our infrastructure in a private network boundary.
# BUSINESS:  Provides the fundamental security perimeter for customer financial data.
# ENGINEER:  We intentionally omit a NAT Gateway to save $32/mo on the Free Tier, relying strictly on Security Groups for protection.
# RECRUITER: Demonstrates proper subnetting, Multi-AZ design for high availability, and explicit routing.
# ══════════════════════════════════════════════════════════

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "fintrack-vpc-${var.environment}"
  }
}

# ---------------------------------------------------------
# INTERNET GATEWAY
# ---------------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "fintrack-igw-${var.environment}"
  }
}

# ---------------------------------------------------------
# PUBLIC SUBNETS (Web/API Tier - Needs Internet)
# ---------------------------------------------------------
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "fintrack-public-a-${var.environment}"
    Tier = "Public"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "fintrack-public-b-${var.environment}"
    Tier = "Public"
  }
}

# ---------------------------------------------------------
# PRIVATE SUBNETS (Database Tier - No direct internet)
# ---------------------------------------------------------
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_a_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "fintrack-private-a-${var.environment}"
    Tier = "Private"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_b_cidr
  availability_zone = "us-east-1b"

  tags = {
    Name = "fintrack-private-b-${var.environment}"
    Tier = "Private"
  }
}

# ---------------------------------------------------------
# ROUTING
# ---------------------------------------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "fintrack-public-rt-${var.environment}"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}
