# Retriving Account ID
data "aws_caller_identity" "current" {}

module "aws_ref" {
  source = "../../"

  project_name = "aws-ref-architecture"
  general_tags = {
    "Project_name" = "aws-ref-architecture"
    "Team"         = "platform-team"
    "Env"          = "dev"
  }

  ### VPC
  create_vpc                = true
  vpc_name                  = "aws-ref-vpc"
  cidr                      = "10.3.0.0/16"
  azs                       = ["us-east-1a", "us-east-1b"]
  public_subnet_cidr        = ["10.3.0.0/20", "10.3.16.0/20"]
  intra_subnet_cidr         = ["10.3.32.0/20", "10.3.48.0/20"]
  db_subnet_cidr            = ["10.3.64.0/20", "10.3.80.0/20"]
  enable_dns_hostnames      = true
  enable_dns_support        = true
  enable_single_nat_gateway = false

  ### Security Groups
  create_alb_sg = true
  alb_sg_name   = "aws-ref-alb-sg"

  create_ec2_sg = true
  ec2_sg_name   = "aws-ref-ec2-sg"

  create_efs_sg = true
  efs_sg_name   = "aws-ref-efs-sg"

  create_rds_sg = true
  rds_sg_name   = "aws-ref-rds-sg"

  create_ssh_sg    = true
  ssh_sg_name      = "aws-ref-ssh-sg"
  ssh_ingress_cidr = ["3.112.23.0/29"]


  ### Primary Database
  create_primary_database             = true
  db_identifier                       = "aws-ref-db"
  create_db_subnet_group              = true
  db_subnet_group_name                = "aws-ref-db-subnet"
  db_name                             = "userlist"
  db_master_username                  = "admin"
  multi_az                            = false
  master_db_availability_zone         = "us-east-1a"
  engine                              = "mysql"
  engine_version                      = "8.0"
  instance_class                      = "db.t3.micro"
  storage_type                        = "gp2"
  allocated_storage                   = "20"
  max_allocated_storage               = "20"
  publicly_accessible                 = false
  database_port                       = 3306
  backup_retention_period             = 7
  backup_window                       = "03:00-05:00"
  maintenance_window                  = "Sat:05:00-Sat:07:00"
  deletion_protection                 = false
  iam_database_authentication_enabled = false
  enabled_cloudwatch_logs_exports     = ["audit", "error"]
  apply_immediately                   = true
  delete_automated_backups            = true
  skip_final_snapshot                 = true

  ### Replica Database
  create_replica_database      = true
  replica_db_identifier        = "aws-ref-db-replica"
  replica_multi_az             = false
  replica_db_availability_zone = "us-east-1b"

  # following inputs can be skipped. If skipped, settings will be inherited from Primary Database
  replica_engine                              = "mysql"
  replica_engine_version                      = "8.0"
  replica_instance_class                      = "db.t3.micro"
  replica_storage_type                        = "gp2"
  replica_max_allocated_storage               = "20"
  replica_publicly_accessible                 = false
  replica_database_port                       = 3306
  replica_backup_retention_period             = 7
  replica_backup_window                       = "03:00-05:00"
  replica_maintenance_window                  = "Sat:05:00-Sat:07:00"
  replica_deletion_protection                 = false
  replica_iam_database_authentication_enabled = false
  replica_enabled_cloudwatch_logs_exports     = ["audit", "error"]
  replica_apply_immediately                   = true
  replica_delete_automated_backups            = true
  replica_skip_final_snapshot                 = true

  ### Elastic File System
  efs_create           = true
  efs_name             = "aws-ref-efs"
  efs_encrypted        = true
  efs_throughput_mode  = "bursting"
  efs_performance_mode = "generalPurpose"
  efs_transition_to_ia = "AFTER_30_DAYS"

  ### Parameters
  create_primary_db_parameters = true
  create_replica_db_parameters = true
  create_efs_parameters        = true

  ### Launch Template
  create_launch_template                 = true
  launch_template_image_id               = "ami-0bb4c991fa89d4b9b" # If not provided, default AMI will be amazonlinux2 of ap-notheast-1
  launch_template_instance_type          = "t2.micro"
  launch_template_key_name               = "ec2-access" # key-pair must be existed on the respective region
  launch_template_update_default_version = true
  launch_template_name_prefix            = "aws-ref"
  launch_template_device_name            = "/dev/xvda"
  launch_template_volume_size            = 10
  launch_template_volume_type            = "gp2"
  launch_template_delete_on_termination  = true
  launch_template_enable_monitoring      = false
  launch_template_userdata_file_path     = "examples/complete/init.sh"
  launch_template_resource_type          = "instance"

  ### ACM - Route53
  create_certificates = true
  acm_domain_names = [
    "test.kubecloud.net",
    "www.test.kubecloud.net",
  ]
  acm_hosted_zone_name       = "kubecloud.net"
  acm_validation_method      = "DNS"
  acm_private_zone           = false
  acm_allow_record_overwrite = true
  acm_ttl                    = 60

  ### ALB
  create_lb                       = true
  alb_name_prefix                 = "awsref"
  load_balancer_type              = "application"
  alb_target_group_name_prefix    = "ref-tg"
  alb_acm_certificate_domain_name = "test.kubecloud.net"

  ### ALB - Route5
  create_alb_route53_record = true

  # if `record name` and `zone name` is not provided. It will be fetched from `ACM-Route53`
  alb_route53_record_names = [
    "test.kubecloud.net",
    "www.test.kubecloud.net",
  ]
  alb_route53_zone_name              = "kubecloud.net"
  alb_route53_record_type            = "A"
  alb_route53_private_zone           = false
  alb_route53_evaluate_target_health = true
  alb_route53_allow_record_overwrite = true

  ### Custom Policy
  create_custom_policy          = true
  custom_iam_policy_name_prefix = "ListAllS3Buckets"
  custom_iam_policy_path        = "/"
  custom_iam_policy_description = "List all s3 buckets"
  custom_iam_policy_json        = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "s3:ListAllMyBuckets",
        "Resource": "*"
      }
    ]
}
EOF

  ### IAM Instance Profile
  create_instance_profile                = true
  instance_profile_role_name             = "aws-ref-instance-role"
  instance_profile_instance_profile_name = "aws-ref-instance-role"
  instance_profile_role_path             = "/"
  instance_profile_managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:aws:iam::aws:policy/AmazonElasticFileSystemClientFullAccess",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy",
  ]
  instance_profile_custom_policy_arns = [
    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/AllowFromJapan",
    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/AllowFromJapanAndGlobalServices",
  ]

  ### Auto Scaling
  asg_create                    = true
  asg_name                      = "aws-ref-asg"
  asg_desired_capacity          = 2
  asg_min_size                  = 2
  asg_max_size                  = 4
  asg_wait_for_capacity_timeout = "5m"
  asg_health_check_type         = "ELB"
  asg_health_check_grace_period = 300
  asg_enable_monitoring         = true
}
