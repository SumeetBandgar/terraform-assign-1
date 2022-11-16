
resource "aws_instance" "name" {
  ami           = var.instance_name
  instance_type = var.instance_type
}
