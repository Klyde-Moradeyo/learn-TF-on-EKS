# AWS Availablity Zones Data source - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
# Command "data.aws_availability_zones.my_azones.names" will return a list. 
data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}


# EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amz_linux2.id
  instance_type = var.instance_type
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [    
                            aws_security_group.vpc-ssh.id, 
                            aws_security_group.vpc-web.id   
                            ]
  # Create EC2 Instance in all Availablity Zones of a VPC
  for_each = toset(data.aws_availability_zones.my_azones.names) # for_each takes a map or a set of Strings NOT a list
  availablity_zone = each.key # You can also use each.value because for list items each.key == each.value
  tags = {
    "Name" = "For-Each-Demo-${each.key}" # e.g For-Each-Demo-US-east-1
  }
}
