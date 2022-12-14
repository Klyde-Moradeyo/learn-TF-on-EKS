# Datasource
# aws ec2 describe-instance-type-offerings --location-type availability-zone  --filters Name=instance-type,Values=t3.micro --region us-east-1 --output table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_instance_type_offerings
data "aws_ec2_instance_type_offerings" "my_ins_type2" {
    for_each = toset([ "eu-west-2a", "eu-west-2b", "eu-west-2c"])
    filter {
        name   = "instance-type"
        values = [ var.instance_type ] 
    }
    filter {
        name   = "location"
        values = [ each.key ]  
    }
    location_type = "availability-zone"
}


# Output
output "output_v1_1" {
    # value = data.aws_ec2_instance_type_offerings.my_ins_type1.instance_types
    value = toset([for t in data.aws_ec2_instance_type_offerings.my_ins_type2: t.instance_types])
}

# Output
output "output_v2_2" {
    # value = data.aws_ec2_instance_type_offerings.my_ins_type1.instance_types
    value = tomap({
        for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2: az => details.instance_types
    })
}