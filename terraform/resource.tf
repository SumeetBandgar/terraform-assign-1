resource "aws_instance" "us_east_1" {
  ami           = var.instance_name_east_us
  instance_type = var.instance_type

  user_data = <<EOF
  #!/bin/bash
  echo "Installed US East region"
  EOF
}

resource "aws_instance" "ap_south_1" {
  ami           = var.instance_name_south_ap
  instance_type = var.instance_type
  provider      = aws.ap-region

  user_data = <<EOF
  #!/bin/bash
  echo "Installed AP South region"
  EOF
}
