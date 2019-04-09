output "bastion_elb_dns" {
  value = "${aws_elb.bastion-k8s-alexandrealvarenga-me.dns_name}"
}
