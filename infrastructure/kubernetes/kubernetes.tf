locals = {
  bastion_autoscaling_group_ids     = ["${aws_autoscaling_group.bastions-k8s-alexandrealvarenga-me.id}"]
  bastion_security_group_ids        = ["${aws_security_group.bastion-k8s-alexandrealvarenga-me.id}"]
  bastions_role_arn                 = "${aws_iam_role.bastions-k8s-alexandrealvarenga-me.arn}"
  bastions_role_name                = "${aws_iam_role.bastions-k8s-alexandrealvarenga-me.name}"
  cluster_name                      = "k8s.alexandrealvarenga.me"
  master_autoscaling_group_ids      = ["${aws_autoscaling_group.master-us-east-1e-masters-k8s-alexandrealvarenga-me.id}"]
  master_security_group_ids         = ["${aws_security_group.masters-k8s-alexandrealvarenga-me.id}"]
  masters_role_arn                  = "${aws_iam_role.masters-k8s-alexandrealvarenga-me.arn}"
  masters_role_name                 = "${aws_iam_role.masters-k8s-alexandrealvarenga-me.name}"
  node_autoscaling_group_ids        = ["${aws_autoscaling_group.nodes-k8s-alexandrealvarenga-me.id}"]
  node_security_group_ids           = ["${aws_security_group.nodes-k8s-alexandrealvarenga-me.id}"]
  node_subnet_ids                   = ["${aws_subnet.us-east-1e-k8s-alexandrealvarenga-me.id}"]
  nodes_role_arn                    = "${aws_iam_role.nodes-k8s-alexandrealvarenga-me.arn}"
  nodes_role_name                   = "${aws_iam_role.nodes-k8s-alexandrealvarenga-me.name}"
  region                            = "us-east-1"
  route_table_private-us-east-1e_id = "${aws_route_table.private-us-east-1e-k8s-alexandrealvarenga-me.id}"
  route_table_public_id             = "${aws_route_table.k8s-alexandrealvarenga-me.id}"
  subnet_us-east-1e_id              = "${aws_subnet.us-east-1e-k8s-alexandrealvarenga-me.id}"
  subnet_utility-us-east-1e_id      = "${aws_subnet.utility-us-east-1e-k8s-alexandrealvarenga-me.id}"
  vpc_id                            = "vpc-05409ba8c527a00d7"
}

output "bastion_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.bastions-k8s-alexandrealvarenga-me.id}"]
}

output "bastion_security_group_ids" {
  value = ["${aws_security_group.bastion-k8s-alexandrealvarenga-me.id}"]
}

output "bastions_role_arn" {
  value = "${aws_iam_role.bastions-k8s-alexandrealvarenga-me.arn}"
}

output "bastions_role_name" {
  value = "${aws_iam_role.bastions-k8s-alexandrealvarenga-me.name}"
}

output "cluster_name" {
  value = "k8s.alexandrealvarenga.me"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-us-east-1e-masters-k8s-alexandrealvarenga-me.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-k8s-alexandrealvarenga-me.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-k8s-alexandrealvarenga-me.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-k8s-alexandrealvarenga-me.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-k8s-alexandrealvarenga-me.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-k8s-alexandrealvarenga-me.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-east-1e-k8s-alexandrealvarenga-me.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-k8s-alexandrealvarenga-me.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-k8s-alexandrealvarenga-me.name}"
}

output "region" {
  value = "us-east-1"
}

output "route_table_private-us-east-1e_id" {
  value = "${aws_route_table.private-us-east-1e-k8s-alexandrealvarenga-me.id}"
}

output "route_table_public_id" {
  value = "${aws_route_table.k8s-alexandrealvarenga-me.id}"
}

output "subnet_us-east-1e_id" {
  value = "${aws_subnet.us-east-1e-k8s-alexandrealvarenga-me.id}"
}

output "subnet_utility-us-east-1e_id" {
  value = "${aws_subnet.utility-us-east-1e-k8s-alexandrealvarenga-me.id}"
}

output "vpc_id" {
  value = "vpc-05409ba8c527a00d7"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_autoscaling_attachment" "bastions-k8s-alexandrealvarenga-me" {
  elb                    = "${aws_elb.bastion-k8s-alexandrealvarenga-me.id}"
  autoscaling_group_name = "${aws_autoscaling_group.bastions-k8s-alexandrealvarenga-me.id}"
}

resource "aws_autoscaling_attachment" "master-us-east-1e-masters-k8s-alexandrealvarenga-me" {
  elb                    = "${aws_elb.api-k8s-alexandrealvarenga-me.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-us-east-1e-masters-k8s-alexandrealvarenga-me.id}"
}

resource "aws_autoscaling_group" "bastions-k8s-alexandrealvarenga-me" {
  name                 = "bastions.k8s.alexandrealvarenga.me"
  launch_configuration = "${aws_launch_configuration.bastions-k8s-alexandrealvarenga-me.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.utility-us-east-1e-k8s-alexandrealvarenga-me.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "k8s.alexandrealvarenga.me"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "bastions.k8s.alexandrealvarenga.me"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "bastions"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/bastion"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "master-us-east-1e-masters-k8s-alexandrealvarenga-me" {
  name                 = "master-us-east-1e.masters.k8s.alexandrealvarenga.me"
  launch_configuration = "${aws_launch_configuration.master-us-east-1e-masters-k8s-alexandrealvarenga-me.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-1e-k8s-alexandrealvarenga-me.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "k8s.alexandrealvarenga.me"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-1e.masters.k8s.alexandrealvarenga.me"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-1e"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-k8s-alexandrealvarenga-me" {
  name                 = "nodes.k8s.alexandrealvarenga.me"
  launch_configuration = "${aws_launch_configuration.nodes-k8s-alexandrealvarenga-me.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-1e-k8s-alexandrealvarenga-me.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "k8s.alexandrealvarenga.me"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.k8s.alexandrealvarenga.me"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "e-etcd-events-k8s-alexandrealvarenga-me" {
  availability_zone = "us-east-1e"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                 = "k8s.alexandrealvarenga.me"
    Name                                              = "e.etcd-events.k8s.alexandrealvarenga.me"
    "k8s.io/etcd/events"                              = "e/e"
    "k8s.io/role/master"                              = "1"
    "kubernetes.io/cluster/k8s.alexandrealvarenga.me" = "owned"
  }
}

resource "aws_ebs_volume" "e-etcd-main-k8s-alexandrealvarenga-me" {
  availability_zone = "us-east-1e"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                 = "k8s.alexandrealvarenga.me"
    Name                                              = "e.etcd-main.k8s.alexandrealvarenga.me"
    "k8s.io/etcd/main"                                = "e/e"
    "k8s.io/role/master"                              = "1"
    "kubernetes.io/cluster/k8s.alexandrealvarenga.me" = "owned"
  }
}

resource "aws_eip" "us-east-1e-k8s-alexandrealvarenga-me" {
  vpc = true

  tags = {
    KubernetesCluster                                 = "k8s.alexandrealvarenga.me"
    Name                                              = "us-east-1e.k8s.alexandrealvarenga.me"
    "kubernetes.io/cluster/k8s.alexandrealvarenga.me" = "owned"
  }
}

resource "aws_elb" "api-k8s-alexandrealvarenga-me" {
  name = "api-k8s-alexandrealvareng-7nmqf0"

  listener = {
    instance_port     = 443
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }

  security_groups = ["${aws_security_group.api-elb-k8s-alexandrealvarenga-me.id}"]
  subnets         = ["${aws_subnet.utility-us-east-1e-k8s-alexandrealvarenga-me.id}"]

  health_check = {
    target              = "SSL:443"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  idle_timeout = 300

  tags = {
    KubernetesCluster = "k8s.alexandrealvarenga.me"
    Name              = "api.k8s.alexandrealvarenga.me"
  }
}

resource "aws_elb" "bastion-k8s-alexandrealvarenga-me" {
  name = "bastion-k8s-alexandrealva-00m1cu"

  listener = {
    instance_port     = 22
    instance_protocol = "TCP"
    lb_port           = 22
    lb_protocol       = "TCP"
  }

  security_groups = ["${aws_security_group.bastion-elb-k8s-alexandrealvarenga-me.id}"]
  subnets         = ["${aws_subnet.utility-us-east-1e-k8s-alexandrealvarenga-me.id}"]

  health_check = {
    target              = "TCP:22"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  idle_timeout = 300

  tags = {
    KubernetesCluster = "k8s.alexandrealvarenga.me"
    Name              = "bastion.k8s.alexandrealvarenga.me"
  }
}

resource "aws_iam_instance_profile" "bastions-k8s-alexandrealvarenga-me" {
  name = "bastions.k8s.alexandrealvarenga.me"
  role = "${aws_iam_role.bastions-k8s-alexandrealvarenga-me.name}"
}

resource "aws_iam_instance_profile" "masters-k8s-alexandrealvarenga-me" {
  name = "masters.k8s.alexandrealvarenga.me"
  role = "${aws_iam_role.masters-k8s-alexandrealvarenga-me.name}"
}

resource "aws_iam_instance_profile" "nodes-k8s-alexandrealvarenga-me" {
  name = "nodes.k8s.alexandrealvarenga.me"
  role = "${aws_iam_role.nodes-k8s-alexandrealvarenga-me.name}"
}

resource "aws_iam_role" "bastions-k8s-alexandrealvarenga-me" {
  name               = "bastions.k8s.alexandrealvarenga.me"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_bastions.k8s.alexandrealvarenga.me_policy")}"
}

resource "aws_iam_role" "masters-k8s-alexandrealvarenga-me" {
  name               = "masters.k8s.alexandrealvarenga.me"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.k8s.alexandrealvarenga.me_policy")}"
}

resource "aws_iam_role" "nodes-k8s-alexandrealvarenga-me" {
  name               = "nodes.k8s.alexandrealvarenga.me"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.k8s.alexandrealvarenga.me_policy")}"
}

resource "aws_iam_role_policy" "bastions-k8s-alexandrealvarenga-me" {
  name   = "bastions.k8s.alexandrealvarenga.me"
  role   = "${aws_iam_role.bastions-k8s-alexandrealvarenga-me.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_bastions.k8s.alexandrealvarenga.me_policy")}"
}

resource "aws_iam_role_policy" "masters-k8s-alexandrealvarenga-me" {
  name   = "masters.k8s.alexandrealvarenga.me"
  role   = "${aws_iam_role.masters-k8s-alexandrealvarenga-me.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.k8s.alexandrealvarenga.me_policy")}"
}

resource "aws_iam_role_policy" "nodes-k8s-alexandrealvarenga-me" {
  name   = "nodes.k8s.alexandrealvarenga.me"
  role   = "${aws_iam_role.nodes-k8s-alexandrealvarenga-me.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.k8s.alexandrealvarenga.me_policy")}"
}

resource "aws_key_pair" "kubernetes-k8s-alexandrealvarenga-me-37b912cea4fb8130fc41d328d4f9139f" {
  key_name   = "kubernetes.k8s.alexandrealvarenga.me-37:b9:12:ce:a4:fb:81:30:fc:41:d3:28:d4:f9:13:9f"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.k8s.alexandrealvarenga.me-37b912cea4fb8130fc41d328d4f9139f_public_key")}"
}

resource "aws_launch_configuration" "bastions-k8s-alexandrealvarenga-me" {
  name_prefix                 = "bastions.k8s.alexandrealvarenga.me-"
  image_id                    = "ami-03b850a018c8cd25e"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-k8s-alexandrealvarenga-me-37b912cea4fb8130fc41d328d4f9139f.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.bastions-k8s-alexandrealvarenga-me.id}"
  security_groups             = ["${aws_security_group.bastion-k8s-alexandrealvarenga-me.id}"]
  associate_public_ip_address = true

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 32
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "master-us-east-1e-masters-k8s-alexandrealvarenga-me" {
  name_prefix                 = "master-us-east-1e.masters.k8s.alexandrealvarenga.me-"
  image_id                    = "ami-03b850a018c8cd25e"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-k8s-alexandrealvarenga-me-37b912cea4fb8130fc41d328d4f9139f.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-k8s-alexandrealvarenga-me.id}"
  security_groups             = ["${aws_security_group.masters-k8s-alexandrealvarenga-me.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-1e.masters.k8s.alexandrealvarenga.me_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-k8s-alexandrealvarenga-me" {
  name_prefix                 = "nodes.k8s.alexandrealvarenga.me-"
  image_id                    = "ami-03b850a018c8cd25e"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-k8s-alexandrealvarenga-me-37b912cea4fb8130fc41d328d4f9139f.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-k8s-alexandrealvarenga-me.id}"
  security_groups             = ["${aws_security_group.nodes-k8s-alexandrealvarenga-me.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.k8s.alexandrealvarenga.me_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_nat_gateway" "us-east-1e-k8s-alexandrealvarenga-me" {
  allocation_id = "${aws_eip.us-east-1e-k8s-alexandrealvarenga-me.id}"
  subnet_id     = "${aws_subnet.utility-us-east-1e-k8s-alexandrealvarenga-me.id}"

  tags = {
    KubernetesCluster                                 = "k8s.alexandrealvarenga.me"
    Name                                              = "us-east-1e.k8s.alexandrealvarenga.me"
    "kubernetes.io/cluster/k8s.alexandrealvarenga.me" = "owned"
  }
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.k8s-alexandrealvarenga-me.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "igw-0384b8d64ecb8d064"
}

resource "aws_route" "private-us-east-1e-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-us-east-1e-k8s-alexandrealvarenga-me.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.us-east-1e-k8s-alexandrealvarenga-me.id}"
}

resource "aws_route53_record" "api-k8s-alexandrealvarenga-me" {
  name = "api.k8s.alexandrealvarenga.me"
  type = "A"

  alias = {
    name                   = "${aws_elb.api-k8s-alexandrealvarenga-me.dns_name}"
    zone_id                = "${aws_elb.api-k8s-alexandrealvarenga-me.zone_id}"
    evaluate_target_health = false
  }

  zone_id = "/hostedzone/ZXLKYZFFIVPDD"
}

resource "aws_route53_record" "bastion-k8s-alexandrealvarenga-me" {
  name = "bastion.k8s.alexandrealvarenga.me"
  type = "A"

  alias = {
    name                   = "${aws_elb.bastion-k8s-alexandrealvarenga-me.dns_name}"
    zone_id                = "${aws_elb.bastion-k8s-alexandrealvarenga-me.zone_id}"
    evaluate_target_health = false
  }

  zone_id = "/hostedzone/ZXLKYZFFIVPDD"
}

resource "aws_route_table" "k8s-alexandrealvarenga-me" {
  vpc_id = "vpc-05409ba8c527a00d7"

  tags = {
    KubernetesCluster                                 = "k8s.alexandrealvarenga.me"
    Name                                              = "k8s.alexandrealvarenga.me"
    "kubernetes.io/cluster/k8s.alexandrealvarenga.me" = "owned"
    "kubernetes.io/kops/role"                         = "public"
  }
}

resource "aws_route_table" "private-us-east-1e-k8s-alexandrealvarenga-me" {
  vpc_id = "vpc-05409ba8c527a00d7"

  tags = {
    KubernetesCluster                                 = "k8s.alexandrealvarenga.me"
    Name                                              = "private-us-east-1e.k8s.alexandrealvarenga.me"
    "kubernetes.io/cluster/k8s.alexandrealvarenga.me" = "owned"
    "kubernetes.io/kops/role"                         = "private-us-east-1e"
  }
}

resource "aws_route_table_association" "private-us-east-1e-k8s-alexandrealvarenga-me" {
  subnet_id      = "${aws_subnet.us-east-1e-k8s-alexandrealvarenga-me.id}"
  route_table_id = "${aws_route_table.private-us-east-1e-k8s-alexandrealvarenga-me.id}"
}

resource "aws_route_table_association" "utility-us-east-1e-k8s-alexandrealvarenga-me" {
  subnet_id      = "${aws_subnet.utility-us-east-1e-k8s-alexandrealvarenga-me.id}"
  route_table_id = "${aws_route_table.k8s-alexandrealvarenga-me.id}"
}

resource "aws_security_group" "api-elb-k8s-alexandrealvarenga-me" {
  name        = "api-elb.k8s.alexandrealvarenga.me"
  vpc_id      = "vpc-05409ba8c527a00d7"
  description = "Security group for api ELB"

  tags = {
    KubernetesCluster                                 = "k8s.alexandrealvarenga.me"
    Name                                              = "api-elb.k8s.alexandrealvarenga.me"
    "kubernetes.io/cluster/k8s.alexandrealvarenga.me" = "owned"
  }
}

resource "aws_security_group" "bastion-elb-k8s-alexandrealvarenga-me" {
  name        = "bastion-elb.k8s.alexandrealvarenga.me"
  vpc_id      = "vpc-05409ba8c527a00d7"
  description = "Security group for bastion ELB"

  tags = {
    KubernetesCluster                                 = "k8s.alexandrealvarenga.me"
    Name                                              = "bastion-elb.k8s.alexandrealvarenga.me"
    "kubernetes.io/cluster/k8s.alexandrealvarenga.me" = "owned"
  }
}

resource "aws_security_group" "bastion-k8s-alexandrealvarenga-me" {
  name        = "bastion.k8s.alexandrealvarenga.me"
  vpc_id      = "vpc-05409ba8c527a00d7"
  description = "Security group for bastion"

  tags = {
    KubernetesCluster                                 = "k8s.alexandrealvarenga.me"
    Name                                              = "bastion.k8s.alexandrealvarenga.me"
    "kubernetes.io/cluster/k8s.alexandrealvarenga.me" = "owned"
  }
}

resource "aws_security_group" "masters-k8s-alexandrealvarenga-me" {
  name        = "masters.k8s.alexandrealvarenga.me"
  vpc_id      = "vpc-05409ba8c527a00d7"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                                 = "k8s.alexandrealvarenga.me"
    Name                                              = "masters.k8s.alexandrealvarenga.me"
    "kubernetes.io/cluster/k8s.alexandrealvarenga.me" = "owned"
  }
}

resource "aws_security_group" "nodes-k8s-alexandrealvarenga-me" {
  name        = "nodes.k8s.alexandrealvarenga.me"
  vpc_id      = "vpc-05409ba8c527a00d7"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                                 = "k8s.alexandrealvarenga.me"
    Name                                              = "nodes.k8s.alexandrealvarenga.me"
    "kubernetes.io/cluster/k8s.alexandrealvarenga.me" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-alexandrealvarenga-me.id}"
  source_security_group_id = "${aws_security_group.masters-k8s-alexandrealvarenga-me.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-k8s-alexandrealvarenga-me.id}"
  source_security_group_id = "${aws_security_group.masters-k8s-alexandrealvarenga-me.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-k8s-alexandrealvarenga-me.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-alexandrealvarenga-me.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "api-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.api-elb-k8s-alexandrealvarenga-me.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.bastion-k8s-alexandrealvarenga-me.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.bastion-elb-k8s-alexandrealvarenga-me.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-to-master-ssh" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-alexandrealvarenga-me.id}"
  source_security_group_id = "${aws_security_group.bastion-k8s-alexandrealvarenga-me.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "bastion-to-node-ssh" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-k8s-alexandrealvarenga-me.id}"
  source_security_group_id = "${aws_security_group.bastion-k8s-alexandrealvarenga-me.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "https-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-k8s-alexandrealvarenga-me.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-elb-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-alexandrealvarenga-me.id}"
  source_security_group_id = "${aws_security_group.api-elb-k8s-alexandrealvarenga-me.id}"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-k8s-alexandrealvarenga-me.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-k8s-alexandrealvarenga-me.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-protocol-ipip" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-alexandrealvarenga-me.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-alexandrealvarenga-me.id}"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "4"
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-alexandrealvarenga-me.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-alexandrealvarenga-me.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4001" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-alexandrealvarenga-me.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-alexandrealvarenga-me.id}"
  from_port                = 2382
  to_port                  = 4001
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-alexandrealvarenga-me.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-alexandrealvarenga-me.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-alexandrealvarenga-me.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-alexandrealvarenga-me.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-elb-to-bastion" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.bastion-k8s-alexandrealvarenga-me.id}"
  source_security_group_id = "${aws_security_group.bastion-elb-k8s-alexandrealvarenga-me.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "ssh-external-to-bastion-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.bastion-elb-k8s-alexandrealvarenga-me.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-east-1e-k8s-alexandrealvarenga-me" {
  vpc_id            = "vpc-05409ba8c527a00d7"
  cidr_block        = "10.0.32.0/19"
  availability_zone = "us-east-1e"

  tags = {
    KubernetesCluster                                 = "k8s.alexandrealvarenga.me"
    Name                                              = "us-east-1e.k8s.alexandrealvarenga.me"
    SubnetType                                        = "Private"
    "kubernetes.io/cluster/k8s.alexandrealvarenga.me" = "owned"
    "kubernetes.io/role/internal-elb"                 = "1"
  }
}

resource "aws_subnet" "utility-us-east-1e-k8s-alexandrealvarenga-me" {
  vpc_id            = "vpc-05409ba8c527a00d7"
  cidr_block        = "10.0.0.0/22"
  availability_zone = "us-east-1e"

  tags = {
    KubernetesCluster                                 = "k8s.alexandrealvarenga.me"
    Name                                              = "utility-us-east-1e.k8s.alexandrealvarenga.me"
    SubnetType                                        = "Utility"
    "kubernetes.io/cluster/k8s.alexandrealvarenga.me" = "owned"
    "kubernetes.io/role/elb"                          = "1"
  }
}

terraform = {
  required_version = ">= 0.9.3"
}
