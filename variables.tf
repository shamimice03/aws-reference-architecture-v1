variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "aws-ref-architecture"
  nullable    = false
}

variable "general_tags" {
  description = "General tags to apply to resources created"
  type        = map(string)
  default = {
    "Project_name" = "aws-ref-architecture"
    "Team"         = "platform-team"
    "Env"          = "dev"
  }
}

######################## VPC ########################
variable "create_vpc" {
  description = "Controls if VPC should be created"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "Id of the VPC.Required while provisioning on an existing VPC"
  type        = string
  default     = ""
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "aws-ref-arch-vpc"
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "azs" {
  description = "Availability Zones for subnets"
  type        = list(string)
  default     = []
}

variable "public_subnet_cidr" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = []
}

# variable "private_subnet_cidr" {
#   description = "CIDR blocks for private subnets"
#   type        = list(string)
#   default     = []
# }

variable "intra_subnet_cidr" {
  description = "CIDR blocks for intra subnets. Used as EFS subnets"
  type        = list(string)
  default     = []
}

variable "db_subnet_cidr" {
  description = "CIDR blocks for database subnets"
  type        = list(string)
  default     = []
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS resolution for the VPC"
  type        = bool
  default     = true
}

variable "enable_single_nat_gateway" {
  description = "Enable a single NAT gateway for all private subnets"
  type        = bool
  default     = false
}

######################## Secuirity Groups ########################
variable "create_alb_sg" {
  description = "Whether to create the Application Load Balancer (ALB) security group."
  type        = bool
  default     = false
}

variable "alb_sg_name" {
  description = "Name of the ALB security group"
  type        = string
  default     = "aws-ref-alb-sg"
}

variable "create_ec2_sg" {
  description = "Whether to create the EC2 instance security group."
  type        = bool
  default     = false
}

variable "ec2_sg_name" {
  description = "Name of the ec2 security group"
  type        = string
  default     = "aws-ref-ec2-sg"
}

variable "create_efs_sg" {
  description = "Whether to create the Elastic File System (EFS) security group."
  type        = bool
  default     = false
}

variable "efs_sg_name" {
  description = "Name of the EFS security group"
  type        = string
  default     = "aws-ref-efs-sg"
}

variable "create_rds_sg" {
  description = "Whether to create the RDS security group."
  type        = bool
  default     = false
}

variable "rds_sg_name" {
  description = "Name of the RDS security group"
  type        = string
  default     = "aws-ref-rds-sg"
}

variable "create_ssh_sg" {
  description = "Whether to create the SSH security group"
  type        = bool
  default     = false
}

variable "ssh_sg_name" {
  description = "Name of the SSH security group"
  type        = string
  default     = "aws-ref-ssh-sg"
}

variable "ssh_ingress_cidr" {
  description = "List of CIDR blocks allowed to SSH into the EC2 instances"
  type        = list(any)
  default     = []
}

######################## Primary Database ###########################
variable "create_primary_database" {
  description = "Whether to create primary database"
  type        = bool
  default     = true
}

variable "db_identifier" {
  description = "The name of the RDS instance"
  type        = string
  default     = "aws-ref-arch-db"
}

variable "create_db_subnet_group" {
  description = "Create a new DB subnet group"
  type        = bool
  default     = true
}

variable "db_subnet_group_name" {
  description = "Name for the DB subnet group"
  type        = string
  default     = "aws-ref-arch-db-subnet"
}

variable "db_subnets" {
  description = "List of DB subnets for the RDS instance"
  type        = list(string)
  default     = []
}

variable "db_name" {
  description = "Name of the initial database"
  type        = string
  default     = ""
}

variable "db_master_username" {
  description = "Master username for the RDS instance"
  type        = string
  default     = ""
}

variable "iam_database_authentication_enabled" {
  description = "Enable IAM database authentication"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Enable multi-AZ deployment for the RDS instance"
  type        = bool
  default     = false
}

variable "master_db_availability_zone" {
  description = "Availability zone for the RDS instance"
  type        = string
  default     = ""
}

variable "engine" {
  description = "Database engine type"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "storage_type" {
  description = "Storage type for the RDS instance"
  type        = string
  default     = "gp2"
}

variable "allocated_storage" {
  description = "Allocated storage for the RDS instance (in GB)"
  type        = string
  default     = "20"
}

variable "max_allocated_storage" {
  description = "Maximum allocated storage for the RDS instance (in GB)"
  type        = string
  default     = "20"
}

variable "db_security_groups" {
  description = "List of security group IDs for the RDS instance"
  type        = list(string)
  default     = []
}

variable "publicly_accessible" {
  description = "Make the RDS instance publicly accessible"
  type        = bool
  default     = false
}

variable "database_port" {
  description = "Port for the RDS instance"
  type        = number
  default     = 3306
}

variable "backup_retention_period" {
  description = "Backup retention period (in days) for the RDS instance"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Preferred backup window for the RDS instance"
  type        = string
  default     = "03:00-05:00"
}

variable "maintenance_window" {
  description = "Maintenance window for the RDS instance"
  type        = string
  default     = "Sat:05:00-Sat:07:00"
}

variable "deletion_protection" {
  description = "Enable or disable deletion protection for the RDS instance"
  type        = bool
  default     = false
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Set of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine). MySQL and MariaDB: audit, error, general, slowquery. PostgreSQL: postgresql, upgrade. MSSQL: agent , error. Oracle: alert, audit, listener, trace."
  type        = list(string)
  default     = ["audit", "error"]
}

variable "apply_immediately" {
  description = "Apply changes immediately or during the next maintenance window"
  type        = bool
  default     = true
}

variable "delete_automated_backups" {
  description = "Delete automated backups when the RDS instance is deleted"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Skip the final DB snapshot when the RDS instance is deleted"
  type        = bool
  default     = true
}

######################## Read Replica ########################
variable "create_replica_database" {
  description = "Whether to create replica database. `create_primary_database` must be `true`"
  type        = bool
  default     = true
}
variable "replica_db_identifier" {
  description = "Identifier for the RDS replica instance"
  type        = string
  default     = ""
}

variable "replica_multi_az" {
  description = "Enable multi-AZ deployment for the RDS replica instance"
  type        = bool
  default     = null
}

variable "replica_db_availability_zone" {
  description = "Availability zone for the RDS replica instance"
  type        = string
  default     = ""
}

variable "replica_engine" {
  description = "Database engine type for the RDS replica instance"
  type        = string
  default     = ""
}

variable "replica_engine_version" {
  description = "Database engine version for the RDS replica instance"
  type        = string
  default     = ""
}

variable "replica_instance_class" {
  description = "RDS instance class for the replica"
  type        = string
  default     = ""
}

variable "replica_storage_type" {
  description = "Storage type for the RDS replica instance"
  type        = string
  default     = ""
}

variable "replica_max_allocated_storage" {
  description = "Maximum allocated storage for the RDS replica instance (in GB)"
  type        = string
  default     = ""
}

variable "replica_publicly_accessible" {
  description = "Make the RDS replica instance publicly accessible"
  type        = bool
  default     = null
}

variable "replica_database_port" {
  description = "Port for the RDS replica instance"
  type        = number
  default     = null
}

variable "replica_backup_retention_period" {
  description = "Backup retention period (in days) for the RDS replica instance"
  type        = number
  default     = null
}

variable "replica_backup_window" {
  description = "Preferred backup window for the RDS replica instance"
  type        = string
  default     = ""
}

variable "replica_maintenance_window" {
  description = "Maintenance window for the RDS replica instance"
  type        = string
  default     = ""
}

variable "replica_deletion_protection" {
  description = "Enable or disable deletion protection for the RDS replica instance"
  type        = bool
  default     = null
}

variable "replica_iam_database_authentication_enabled" {
  description = "Enable IAM database authentication"
  type        = bool
  default     = null
}

variable "replica_enabled_cloudwatch_logs_exports" {
  description = "Set of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine). MySQL and MariaDB: audit, error, general, slowquery. PostgreSQL: postgresql, upgrade. MSSQL: agent , error. Oracle: alert, audit, listener, trace."
  type        = list(string)
  default     = []
}

variable "replica_apply_immediately" {
  description = "Apply changes immediately or during the next maintenance window for the replica"
  type        = bool
  default     = null
}

variable "replica_delete_automated_backups" {
  description = "Delete automated backups when the RDS replica instance is deleted"
  type        = bool
  default     = null
}

variable "replica_skip_final_snapshot" {
  description = "Skip the final DB snapshot when the RDS replica instance is deleted"
  type        = bool
  default     = null
}


######################## EFS ########################
variable "efs_create" {
  description = "Whether to create Elastic File System"
  type        = bool
  default     = false
}

variable "efs_name" {
  description = "Name of the Elastic File System"
  type        = string
  default     = ""
}

variable "efs_mount_target_subnet_ids" {
  description = "List of subnet IDs for EFS mount targets"
  type        = list(string)
  default     = []
}

variable "efs_mount_target_security_group_ids" {
  description = "List of security group IDs for EFS mount targets"
  type        = list(string)
  default     = []
}

variable "efs_encrypted" {
  description = "Whether to enable encryption for the EFS file system"
  type        = bool
  default     = true
}

variable "efs_throughput_mode" {
  description = "The throughput mode for the EFS file system (e.g., 'bursting' or 'provisioned')"
  type        = string
  default     = "bursting"
}

variable "efs_performance_mode" {
  description = "The performance mode for the EFS file system (e.g., 'generalPurpose' or 'maxIO')"
  type        = string
  default     = "generalPurpose"
}

variable "efs_transition_to_ia" {
  description = "The lifecycle policy transition for files to Infrequent Access (IA) storage"
  type        = string
  default     = "AFTER_30_DAYS"
}

######################## SSM Parameters  ########################
variable "create_primary_db_parameters" {
  description = "Whether to store primary database parameters on SSM parameter store"
  type        = bool
  default     = false
}

variable "create_replica_db_parameters" {
  description = "Whether to store replica database parameters on SSM parameter store"
  type        = bool
  default     = false
}

variable "create_efs_parameters" {
  description = "Whether to store efs parameters on SSM parameter store"
  type        = bool
  default     = false
}

######################## Launch Template ########################
variable "create_launch_template" {
  description = "Whether to create new launch template"
  type        = bool
  default     = true
}

variable "launch_template_image_id" {
  description = "The AMI from which to launch the instance. Default will be `Amazonlinux2`"
  type        = string
  default     = ""
}

variable "launch_template_instance_type" {
  description = "The EC2 instance type for instances launched from the template"
  type        = string
  default     = "t2.micro"
}

variable "launch_template_key_name" {
  description = "The name of the SSH key pair to associate with instances launched from the template"
  type        = string
  default     = ""
}

variable "launch_template_update_default_version" {
  description = "Flag to update the default version of the launch template"
  type        = bool
  default     = true
}

variable "launch_template_name_prefix" {
  description = "Creates a unique name beginning with the specified prefix"
  type        = string
  default     = "aws-ref"
}

variable "launch_template_sg_ids" {
  description = "List of security group IDs for the launch template"
  type        = list(string)
  default     = []
}

variable "launch_template_device_name" {
  description = "The device name for the root volume"
  type        = string
  default     = "/dev/xvda"
}

variable "launch_template_volume_size" {
  description = "The size of the root volume for instances launched from the template (in GiB)"
  type        = number
  default     = 20
}

variable "launch_template_volume_type" {
  description = "The type of volume for the root volume (e.g., 'gp2')"
  type        = string
  default     = "gp2"
}

variable "launch_template_delete_on_termination" {
  description = "Whether the root volume should be deleted on instance termination"
  type        = bool
  default     = true
}

variable "launch_template_enable_monitoring" {
  description = "Whether instance monitoring should be enabled"
  type        = bool
  default     = false
}

variable "launch_template_userdata_file_path" {
  description = "Path to the user data script file"
  type        = string
  default     = ""
}

variable "launch_template_resource_type" {
  description = "The type of resource to tag"
  type        = string
  default     = "instance"
}

######################## ACM - Route53 ########################
variable "create_certificates" {
  description = "Controls if certificate should be generated"
  type        = bool
  default     = true
}

variable "acm_domain_names" {
  description = "Domain name for ACM certificate"
  type        = list(string)
  default     = []
}

variable "acm_validation_method" {
  description = "Validation method for ACM certificate"
  type        = string
  default     = "DNS"
}

variable "acm_hosted_zone_name" {
  description = "Hosted zone name for DNS validation"
  type        = string
  default     = ""
}

variable "acm_private_zone" {
  description = "Whether the hosted zone is private or not"
  type        = bool
  default     = false
}

variable "acm_allow_record_overwrite" {
  description = "Allow record overwrite in DNS validation"
  type        = bool
  default     = true
}

variable "acm_ttl" {
  description = "Time to live (TTL) for DNS records"
  type        = number
  default     = 60
}

######################## ALB ########################
variable "create_lb" {
  description = "Controls if the Load Balancer should be created"
  type        = bool
  default     = true
}

variable "alb_name_prefix" {
  description = "Prefix for the Application Load Balancer name"
  type        = string
  default     = ""
}

variable "load_balancer_type" {
  description = "Type of the Load Balancer"
  type        = string
  default     = "application"
}

variable "alb_subnets" {
  description = "List of subnet IDs for the Application Load Balancer (ALB)"
  type        = list(string)
  default     = []
}

variable "alb_security_groups" {
  description = "List of security group IDs for the Application Load Balancer (ALB)"
  type        = list(string)
  default     = []
}

variable "alb_target_group_name_prefix" {
  description = "Prefix for the ALB target group name"
  type        = string
  default     = ""
}

variable "alb_acm_certificate_domain_name" {
  description = "ACM Certificate domain name"
  type        = string
  default     = ""
}

######################### ALB - Route53 ###################
variable "create_alb_route53_record" {
  description = "Whether to create ALB - Route53 record"
  type        = bool
  default     = true
}

variable "alb_route53_zone_name" {
  description = "The DNS zone name"
  type        = string
  default     = ""
}

variable "alb_route53_record_names" {
  description = "The DNS record name for the first ALB record"
  type        = list(string)
  default     = []
}

variable "alb_route53_record_type" {
  description = "The DNS record type for ALB records"
  type        = string
  default     = "A"
}

variable "alb_route53_private_zone" {
  description = "Whether the DNS zone is private or not"
  type        = bool
  default     = false
}

variable "alb_route53_evaluate_target_health" {
  description = "Whether to evaluate the target health of the ALB"
  type        = bool
  default     = true
}

variable "alb_route53_allow_record_overwrite" {
  description = "Allow creation of this record in Terraform to overwrite an existing record"
  type        = bool
  default     = false
}

######################## Create custom policy ########################
variable "create_custom_policy" {
  description = "Whether to create custom policy"
  type        = bool
  default     = false
}

variable "custom_iam_policy_name_prefix" {
  description = "Prefix for the IAM policy name. Required if `create_custom_policy` set to `true`"
  type        = string
  default     = ""
}

variable "custom_iam_policy_path" {
  description = "The path for the IAM policy. Required if `create_custom_policy` set to `true`"
  type        = string
  default     = "/"
}

variable "custom_iam_policy_description" {
  description = "Description for the IAM policy. Required if `create_custom_policy` set to `true`"
  type        = string
  default     = "custom policy"
}

variable "custom_iam_policy_json" {
  description = "JSON policy document. Required if `create_custom_policy` set to `true`"
  type        = string
  default     = ""
}

######################## IAM Instance Profile ########################
variable "create_instance_profile" {
  description = "Whether to create an instance profile"
  type        = bool
  default     = true
}

variable "instance_profile_role_name" {
  description = "Name of the IAM role associated with the instance profile"
  type        = string
  default     = "aws-ref-instance-role"
}

variable "instance_profile_instance_profile_name" {
  description = "Name of the IAM instance profile"
  type        = string
  default     = ""
}

variable "instance_profile_managed_policy_arns" {
  description = "List of ARNs of managed policies to attach to the role"
  type        = list(string)
  default     = []
}

variable "instance_profile_custom_policy_arns" {
  description = "List of ARNs of custom policies(created outside of this project) to attach to the role"
  type        = list(string)
  default     = []
}

variable "instance_profile_role_path" {
  description = "The path for the IAM role"
  type        = string
  default     = "/"
}

######################## AutoScaling Group  ########################
variable "asg_create" {
  description = "Whether to create asg or not. asg dependent on `Launch Template`"
  type        = bool
  default     = true
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
  default     = ""
}

variable "asg_vpc_zone_identifier" {
  description = "List of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Required if `VPC` is not created as part of this project"
  type        = list(string)
  default     = []
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "asg_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "asg_wait_for_capacity_timeout" {
  description = "Timeout for waiting for the desired capacity to be reached"
  type        = string
  default     = "10m"
}

variable "asg_health_check_type" {
  description = "Health check type for the Auto Scaling Group"
  type        = string
  default     = "ELB"
}

variable "asg_health_check_grace_period" {
  description = "Health check grace period for instances in the Auto Scaling Group"
  type        = number
  default     = 300
}

variable "asg_enable_monitoring" {
  description = "Enable monitoring for the Auto Scaling Group"
  type        = bool
  default     = true
}
