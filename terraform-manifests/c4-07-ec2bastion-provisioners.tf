# Create a Null Resource and Provisioners
#
# Copy the private-key of my EC2 keypair into 
# the bastion Ec2 instance
resource "null_resource" "copy_ec2_keys" {
    depends_on = [ module.ec2_public ] # null_resource executes after modul ec2_public is ready

    # connection block for provisoners to connect to Ec2 Instrance
    connection {
        type = "ssh"
        host = aws_eip.bastion_eip.public_ip
        user = "ec2-user"
        password = ""
        private_key = file("private-key/terraform-key.pem")
    }

    # file provisioners: copies the terraform-key.pen file to /tmp/eks-terraform-key.pem
    provisioner "file" {
        source = "private-key/terraform-key.pem"
        destination = "/tmp/eks-terraform-key.pem" # /tmp/ has full access to copy
    }

    # Remote Exec provisioners fix the private key permissions in bastion host
    provisioner "remote-exec" {
        inline = [
            "sudo chmod 400 private-key/terraform-key.pem"
        ]
    }

    # local exec provisioner: local-exec provisoion (creation-time provisioner)
    provisioner "local-exec" {
        # command is going to get the vpc id.
        command = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
        working_dir = "local-exec-output-files"
    }
}