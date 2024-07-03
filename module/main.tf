module "vpc" {
    source = "./vpc_module"
    environment = "Dev" 
    vpc_cidr             = "192.168.0.0/16"
    public_subnets_cidr  = ["192.168.1.0/24", "192.168.2.0/24"]
    private_subnets_cidr = ["192.168.3.0/24", "192.168.4.0/24"]
    availability_zone   = ["ap-northeast-1a", "ap-northeast-1c"]
}


module "eks" {
    source = "./eks_module"
    cluster_name = "my_cluster"
    kubernetes_version = "1.29" 
    iam_role = "eks-cluster-role"
    node_group_name = "eks-nodes"
    instance_type = "t3.medium"
    max_available_config = 2
    public_subnet_1 = module.vpc.public-subnet-id-1
    public_subnet_2 = module.vpc.public-subnet-id-2
    private_subnet_1 = module.vpc.private-subnet-id-1
    private_subnet_2 = module.vpc.private-subnet-id-2
    core_dns = "coredns"
    core_dns_version = "v1.11.1-eksbuild.9"
    vpc_cni = "vpc-cni"
    vpc_cni_version = "v1.18.2-eksbuild.1"
    kube_proxy = "kube-proxy"
    kube_proxy_version = "v1.29.3-eksbuild.5"
    
}
module "rds" {
  source = "./rds_module" 
  identifier             = "for-eks"
  storage                = "20"
  engine                 = "mysql"
  engine_version         = "8.0.32"
  instance_class         = "db.t3.micro"
  db_name                = "mydb"
  username               = "root"
  password               = "root12345"	
  subnet_ids = ["${module.vpc.public-subnet-id-1}", "${module.vpc.public-subnet-id-2}"]
  vpc_id = module.vpc.vpc-id
}
