##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_session_token
  region     = var.region
}

##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {}

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
resource "aws_vpc" "testVPC" {
  cidr_block           = var.network_address_space
  enable_dns_hostnames = true

  tags = merge(local.common_tags, { Name = "${var.cName}-VPC" })
}

resource "aws_internet_gateway" "testIgw" {
  vpc_id = aws_vpc.testVPC.id

  tags = merge(local.common_tags, { Name = "${var.cName}-IGW" })
}


resource "aws_subnet" "Publics" {
  for_each                = var.subnettag
  cidr_block              = var.subnet_address_space[each.value.subnet_name].cidr_block
  vpc_id                  = aws_vpc.testVPC.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[each.value.availability_zone]

  tags = merge(local.common_tags, { Name = "${var.cName}-${each.value.subnet_name}" })
}

# ROUTING #
resource "aws_route_table" "publicRoute" {
  vpc_id = aws_vpc.testVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.testIgw.id
  }

  tags = merge(local.common_tags, { Name = "${var.cName}-PublicRouteTable" })
}

resource "aws_route_table_association" "rt-pubsub" {
  for_each       = aws_subnet.Publics
  subnet_id      = each.value.id
  route_table_id = aws_route_table.publicRoute.id
}

# SECURITY GROUPS #
# ALB Security Group
resource "aws_security_group" "elb-sg" {
  name   = "elb_sg"
  vpc_id = aws_vpc.testVPC.id

  #Allow HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${var.cName}-elbSG" })

}


resource "aws_security_group" "allow_ssh_web" {
  name   = "npaWk13_solution"
  vpc_id = aws_vpc.testVPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.network_address_space]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${var.cName}-serverSG" })
}