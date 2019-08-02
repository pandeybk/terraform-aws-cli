
Custom aws and shell provider which will outout ip addresses, dns name and instance ids for asg.

Example:
```
output "public_ip_addresses" {
    value = "${data.aws_autoscaling_group.test.public_ip_addresses}"
}

output "private_ip_addresses" {
    value = "${data.aws_autoscaling_group.test.private_ip_addresses}"
}

output "private_dns_names" {
    value = "${data.aws_autoscaling_group.test.private_dns_names}"
}

output "instance_ids" {
    value = "${data.aws_autoscaling_group.test.instance_ids}"
}
```