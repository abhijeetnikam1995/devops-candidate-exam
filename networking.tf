# network.tf

//resource "aws_vpc" "test-vpc" {
 // cidr_block = "172.16.0.0/16"
//}

# Fetch AZs in the current region
data "aws_availability_zones" "available" {
}


# Create var.az_count private subnets, each in a different AZ
resource "aws_subnet" "private" {
  count             = var.az_count
 // cidr_block        = cidrsubnet(aws_vpc.test-vpc.cidr_block, 8, count.index)
   cidr_block        = cidrsubnet(data.aws_vpc.vpc.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
 // vpc_id            = aws_vpc.test-vpc.id
  vpc_id            = data.aws_vpc.vpc.id
}

# Create var.az_count public subnets, each in a different AZ
resource "aws_subnet" "public" {
  count                   = var.az_count
//  cidr_block              = cidrsubnet(aws_vpc.test-vpc.cidr_block, 8, var.az_count + count.index)
  cidr_block              = cidrsubnet(data.aws_vpc.vpc.cidr_block, 8, var.az_count + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
//  vpc_id                  = aws_vpc.test-vpc.id
  vpc_id            = data.aws_vpc.vpc.id
  map_public_ip_on_launch = true
}

# Internet Gateway for the public subnet
//resource "aws_internet_gateway" "test-igw" {
 // vpc_id = aws_vpc.test-vpc.id
//  vpc_id            = data.aws_vpc.vpc.id
//}

# Route the public subnet traffic through the IGW
resource "aws_route" "internet_access" {
 // route_table_id         = aws_vpc.test-vpc.main_route_table_id
  route_table_id         = data.aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
 // gateway_id             = aws_internet_gateway.test-igw.id
  gateway_id             = data.aws_nat_gateway.nat.id
}

# Create a NAT gateway with an Elastic IP for each private subnet to get internet connectivity
//resource "aws_eip" "test-eip" {
//  count      = var.az_count
//  vpc        = true
//  depends_on = [aws_internet_gateway.test-igw]
//}

//resource "aws_nat_gateway" "test-natgw" {
 // count         = var.az_count
  // subnet_id     = element(aws_subnet.public.*.id, count.index)
 // allocation_id = element(aws_eip.test-eip.*.id, count.index)
// }

# Create a new route table for the private subnets, make it route non-local traffic through the NAT gateway to the internet
resource "aws_route_table" "private" {
  count  = var.az_count
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
 //   nat_gateway_id = element(aws_nat_gateway.test-natgw.*.id, count.index)
     nat_gateway_id = element(data.aws_nat_gateway.nat.*.id, count.index)
  }
}

# Explicitly associate the newly created route tables to the private subnets (so they don't default to the main route table)
resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
