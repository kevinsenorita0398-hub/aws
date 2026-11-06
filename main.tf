provider "aws" {
  region = "ap-south-1"
  shared_credentials_files = ["~/.aws/credentials"]
  
}
resource "aws_vpc" "tes_vpc" {
  cidr_block = "10.0.0.0/16"

}
resource "aws_subnet" "test_subnet" {
  vpc_id = aws_vpc.tes_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"

}
resource "aws_internet_gateway" "test_gateway" {
  vpc_id = aws_vpc.tes_vpc.id
}
resource "aws_route_table" "test_table" {
 vpc_id = aws_vpc.tes_vpc.id
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.test_gateway.igw.id
}
}
resource "aws_route_table_association" "test_association" {
  subnet_id = aws_subnet.test_subnet.id
  route_table_id = aws_route_table.test_table.id
}
