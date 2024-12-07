resource "aws_key_pair" "eks" {
  key_name = "eks"
  # you can paste the public key directly like this
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDW8fMOrnf8AnRODLrqnrA/LBVn/9HpreeLHPNntXQQOcbmCjvWrWZmsa3M2a5f7kgL2/jcYjCYqWmvfuU8vdj6kOJO8oe/gNtK7fL6bNWZ7MWW/nCDTo00qBuR7FPtNMoDjYKSpP5RzgRmcj55UcX6MLEY28tRzl5VxzLUTVpoSSfzZyC8/enM61E88TWkAt2JkE9HXPRK2UR0qrtMwlgFPiqk+5Ym1LCNAfsc1OBWySnQIXIE6tRlnFNmKGAwghyLsL4YK/8O9RKSYGS2giMXhc1LULDrU5y3au+NJux43jkeocmmxfU7YAOg3tmxczxaRci/OVLv1CoUeZ8SwLiDZX+Daus0Ae/ML3y298OQgpUdOyoiMQXyISiGunj9PYRzU+SnKkbATxJKy5CxK1YbiMgUgbxSbIaKIzIEg+h04xRfyScfndW4OMq8elvHWKE0qYe3RlN+ZDz38u76/x5WPRdrqavRYBQaHC+iL5UX/fITlUXcrOnb0YQYNpNkIXM= yeswanth@DESKTOP-UH7DRI1"
  #public_key = file("~/.ssh/eks.pub")
  #public_key = file("D:/joindevops/eks.pub")
  # ~ means windows home directory
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"


  cluster_name    = "${var.project_name}-${var.environment}"
  cluster_version = "1.30"
  # need to update cluster version here after upgrading the k8s version in aws console

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = data.aws_ssm_parameter.vpc_id.value
  subnet_ids               = local.private_subnet_ids
  control_plane_subnet_ids = local.private_subnet_ids

  create_cluster_security_group = false
  cluster_security_group_id     = local.eks_control_plane_sg_id

  create_node_security_group = false
  node_security_group_id     = local.node_sg_id

  # the user which you used to create cluster will get admin access

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  # comment and uncomment the blue and green node groups accordingly for creating & deleting while version upgrade
  eks_managed_node_groups = {
    blue = {
      min_size     = 2
      max_size     = 10
      desired_size = 2
      #capacity_type = "SPOT"
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonElasticFileSystemFullAccess = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        ElasticLoadBalancingFullAccess    = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
      }
      # EKS takes AWS Linux 2 as it's OS to the nodes
      key_name = aws_key_pair.eks.key_name
    }
    # green = {
    #   min_size      = 2
    #   max_size      = 10
    #   desired_size  = 2
    #   #capacity_type = "SPOT"
    #   iam_role_additional_policies = {
    #     AmazonEBSCSIDriverPolicy          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    #     AmazonElasticFileSystemFullAccess = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
    #     ElasticLoadBalancingFullAccess = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
    #   }
    #   # EKS takes AWS Linux 2 as it's OS to the nodes
    #   key_name = aws_key_pair.eks.key_name
    # }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  tags = var.common_tags
}