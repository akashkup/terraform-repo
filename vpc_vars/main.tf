resource "aws_vpc" "vpc_var" {
  cidr_block = "10.0.0.0/18"

  tags = {
    Name = "vpc_var"
  }
}

resource "aws_subnet" "public_subnets" {
    count = length(var.public_cidr)
    vpc_id = aws_vpc.vpc_var.id
    availability_zone = element(var.azs, count.index)
    cidr_block = element(var.public_cidr, count.index)
   tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}
  


resource "aws_subnet" "private_subnets" {
    count = length(var.private_cidr)
    vpc_id = aws_vpc.vpc_var.id
    availability_zone = element(var.azs, count.index)
    cidr_block = element(var.private_cidr, count.index)

     tags = {
   Name = "Private Subnet ${count.index + 1}"
 }
}

resource "aws_internet_gateway" "igw" {
 vpc_id = aws_vpc.vpc_var.id
 
 tags = {
   Name = "Project VPC IG for variables"
 }
}
resource "aws_instance" "web" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t3.micro"
  

  tags = {
    Name = "HelloWorld"
  }
}
resource "aws_eip" "lb" {
  instance = aws_instance.web.id
  domain   = "vpc"
}

/*resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.example.id
  subnet_id     = aws_subnet.example.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.example]
}*/

resource "aws_route_table" "public_rt" {
 vpc_id = aws_vpc.vpc_var.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id
 }
 
 tags = {
   Name = "2nd Route Table"
 }
}

resource "aws_route_table" "private_rt" {
 vpc_id = aws_vpc.vpc_var.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id
 }
 
 tags = {
   Name = "2nd Route Table"
 }
}
resource "aws_route_table_association" "public_subnet_asso" {
 count = length(var.public_cidr)
 subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
 route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_subnet_asso" {
 count = length(var.private_cidr)
 subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
 route_table_id = "rtb-04471cb2cd05ecb02"
}