resource "aws_instance" "web" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}

output "ec2_ip" {
  value = aws_instance.web
}

#to output  values to file_command==>terraform output >> file.txt(path)      or
