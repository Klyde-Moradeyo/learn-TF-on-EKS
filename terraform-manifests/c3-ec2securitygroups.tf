# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc-ssh" {
    name        = "vpc-ssh"
    description = "Dev VPC SSH"
    # vpc_id      = aws_vpc.main.id # We don't need this since we're creating this in the default VPC

    # Inbound Rules
    ingress {
        description      = "Allow Port 22"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"] # Internet traffic 0.0.0.0/0
    }

    # Outbound
    egress {
        descript         = "Allow all IP and Ports outbound"
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
        Name = "vpc-ssh"
    }
}

# Create Security Group - Web Traffic
resource "aws_security_group" "vpc-web" {
    name        = "vpc-web"
    description = "Dev VPC Web"
    # vpc_id      = aws_vpc.main.id # We don't need this since we're creating this in the default VPC

    # Inbound Rules
    ingress {
        description      = "Allow Port 80"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"] # Internet traffic 0.0.0.0/0
    }
    ingress {
        description      = "Allow Port 443"
        from_port        = 443
        to_port          = 443
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"] # Internet traffic 0.0.0.0/0
    }


    # Outbound
    egress {
        descript         = "Allow all IP and Ports outbound"
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
        Name = "vpc-web"
    }
}