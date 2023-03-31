resource "aws_instance" "ec2_instance" {

  ami             = var.ami
  instance_type   = var.instype
  security_groups = [aws_security_group.raghav_sgroup.name]

  tags =var.tags
#    {
#     Name    = "Raghav"
#     Owner   = "raghav.khurana@cloudeq.com"
#     Purpose = "training"
#   }
  volume_tags =var.tags
#   {
#     Name    = "Raghav"
#     Owner   = "raghav.khurana@cloudeq.com"
#     Purpose = "training"

#     "availability_zone" = "us-east-1"

#   }
}

# resource "aws_ebs_volume" "example" {
#   availability_zone = "us-east-1"
#   size              = 2

# tags = {
#     Name    = "Raghav123"
#     Owner   = "raghav.khurana@cloudeq.com"
#     Purpose = "training"
#   }
# }


# resource "aws_volume_attachment" "ebs_att" {
#   device_name = "../"
#   volume_id   = aws_ebs_volume.example.id
#   instance_id = aws_instance.ec2_instance.id
# }


# resource "aws_ebs_volume" "raghav" {
#   availability_zone = "us-east-1"
#   size              = 2

#   tags = {
#     Name    = "Raghav"
#     Owner   = "raghav.khurana@cloudeq.com"
#     Purpose = "training"
#   }
# }

resource "aws_ebs_volume" "ebsvol"{
 availability_zone = aws_instance.ec2_instance.availability_zone 
 size = var.volsize
 tags =var.tags
#   {
#     Name    = "Raghav"
#     Owner   = "raghav.khurana@cloudeq.com"
#     Purpose = "training"
#   }
}

resource "aws_volume_attachment" "attach_ebs_1"{
device_name = "/dev/sdh"
volume_id = aws_ebs_volume.ebsvol.id
instance_id =aws_instance.ec2_instance.id
}

resource "aws_security_group" "raghav_sgroup" {
  name        = "raghavsg"
  vpc_id      = "vpc-076eb9b0fa60396b5"
  description = "sgroup"
  dynamic "ingress" {
    for_each = [9090, 80]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
#   {
#     Name    = "Raghav"
#     Owner   = "raghav.khurana@cloudeq.com"
#     Purpose = "training"


#   }
}
