# Terraform Output Values
/* Concepts Covered
1. For Loop with List
2. For Loop with Map
3. For Loop with Map Advanced
4. Legacy Splat Operator (latest) - Returns List
5. Latest Generalized Splat Operator - Returns the List
*/

# Output - For loop with list
output "for_output_list" { 
    description = "For Loop with List"
    value = [ for instance in aws_instance.myec2vm: instance.public_dns ] # Output the public dns of each resource created
}

# Output - For loop with map
output "for_output_map1" {
    description = "For Loop with Map"
    value = { for instance in aws_instance.myec2vm: instance.id => instance.public_dn }
}

# Output - For Loop with Map Advanced
output "for_output_map2" {
    description = "For Loop with Map - Advanced"
    value = { for c, instance in aws_instance.myec2vm: c => instance.public_dns } # For each count number (c) get the public dns
}

# Output Legacy Splat operator (Legacy) - Returns a list
output "legacy_splat_instance_publicdns" {
    description = "Legacy Splat Operator"
    value = aws_instance.myec2vm.*.public_dns
}

# Output Legacy Generalized Splat operator - Returns a list
output "letest_splat_instance_publicdns" {
    description = "Generalized Splat Operator"
    value = aws_instance.myec2vm[*].public_dns
}