resource "aws_instance" "web" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}