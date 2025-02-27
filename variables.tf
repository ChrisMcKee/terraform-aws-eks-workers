variable "namespace" {
  type        = "string"
  description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
}

variable "stage" {
  type        = "string"
  description = "Stage, e.g. 'prod', 'staging', 'dev', or 'test'"
}

variable "environment" {
  type        = "string"
  default     = ""
  description = "Environment, e.g. 'testing', 'UAT'"
}

variable "name" {
  type        = "string"
  default     = "app"
  description = "Solution name, e.g. 'app' or 'cluster'"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. `{ BusinessUnit = \"XYZ\" }`"
}

variable "enabled" {
  type        = "string"
  description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources"
  default     = "true"
}

variable "cluster_name" {
  type        = "string"
  description = "The name of the EKS cluster"
}

variable "cluster_endpoint" {
  type        = "string"
  description = "EKS cluster endpoint"
}

variable "cluster_certificate_authority_data" {
  type        = "string"
  description = "The base64 encoded certificate data required to communicate with the cluster"
}

variable "cluster_security_group_id" {
  type        = "string"
  description = "Security Group ID of the EKS cluster"
}

variable "vpc_id" {
  type        = "string"
  description = "VPC ID for the EKS cluster"
}

variable "allowed_security_groups" {
  type        = "list"
  default     = []
  description = "List of Security Group IDs to be allowed to connect to the worker nodes"
}

variable "allowed_security_groups_count" {
  default = 0
}

variable "allowed_cidr_blocks" {
  type        = "list"
  default     = []
  description = "List of CIDR blocks to be allowed to connect to the worker nodes"
}

variable "instance_initiated_shutdown_behavior" {
  type        = "string"
  description = "Shutdown behavior for the instances. Can be `stop` or `terminate`"
  default     = "terminate"
}

variable "image_id" {
  type        = "string"
  description = "EC2 image ID to launch. If not provided, the module will lookup the most recent EKS AMI. See https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html for more details on EKS-optimized images"
  default     = ""
}

variable "use_custom_image_id" {
  type        = "string"
  description = "If set to `true`, will use variable `image_id` to run EKS workers inside autoscaling group"
  default     = "false"
}

variable "eks_worker_ami_name_filter" {
  type        = "string"
  description = "AMI name filter to lookup the most recent EKS AMI if `image_id` is not provided"
  default     = "amazon-eks-node-*"
}

variable "eks_worker_ami_name_regex" {
  type        = "string"
  description = "A regex string to apply to the AMI list returned by AWS"
  default     = "^amazon-eks-node-[1-9,\\.]+-v\\d{8}$"
}

variable "instance_type" {
  type        = "string"
  description = "Instance type to launch"
}

variable "key_name" {
  type        = "string"
  description = "SSH key name that should be used for the instance"
  default     = ""
}

variable "associate_public_ip_address" {
  description = "Associate a public IP address with an instance in a VPC"
  default     = false
}

variable "enable_monitoring" {
  description = "Enable/disable detailed monitoring"
  default     = true
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"
  type        = "list"
  default     = []
}

variable "instance_market_options" {
  description = "The market (purchasing) option for the instances"
  type        = "list"
  default     = []
}

variable "placement" {
  description = "The placement specifications of the instances"
  type        = "list"
  default     = []
}

variable "credit_specification" {
  description = "Customize the credit specification of the instances"
  type        = "list"
  default     = []
}

variable "elastic_gpu_specifications" {
  description = "Specifications of Elastic GPU to attach to the instances"
  type        = "list"
  default     = []
}

variable "disable_api_termination" {
  description = "If `true`, enables EC2 Instance Termination Protection"
  default     = false
}

variable "max_size" {
  description = "The maximum size of the autoscale group"
}

variable "min_size" {
  description = "The minimum size of the autoscale group"
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch resources in"
  type        = "list"
}

variable "default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = 300
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = 300
}

variable "health_check_type" {
  type        = "string"
  description = "Controls how health checking is done. Valid values are `EC2` or `ELB`"
  default     = "EC2"
}

variable "force_delete" {
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  default     = false
}

variable "load_balancers" {
  type        = "list"
  description = "A list of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use `target_group_arns` instead"
  default     = []
}

variable "target_group_arns" {
  type        = "list"
  description = "A list of aws_alb_target_group ARNs, for use with Application Load Balancing"
  default     = []
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are `OldestInstance`, `NewestInstance`, `OldestLaunchConfiguration`, `ClosestToNextInstanceHour`, `Default`"
  type        = "list"
  default     = ["Default"]
}

variable "suspended_processes" {
  type        = "list"
  description = "A list of processes to suspend for the AutoScaling Group. The allowed values are `Launch`, `Terminate`, `HealthCheck`, `ReplaceUnhealthy`, `AZRebalance`, `AlarmNotification`, `ScheduledActions`, `AddToLoadBalancer`. Note that if you suspend either the `Launch` or `Terminate` process types, it can prevent your autoscaling group from functioning properly."
  default     = []
}

variable "placement_group" {
  type        = "string"
  description = "The name of the placement group into which you'll launch your instances, if any"
  default     = ""
}

variable "metrics_granularity" {
  type        = "string"
  description = "The granularity to associate with the metrics to collect. The only valid value is 1Minute"
  default     = "1Minute"
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are `GroupMinSize`, `GroupMaxSize`, `GroupDesiredCapacity`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupTerminatingInstances`, `GroupTotalInstances`"
  type        = "list"

  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "wait_for_capacity_timeout" {
  type        = "string"
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to '0' causes Terraform to skip all Capacity Waiting behavior"
  default     = "10m"
}

variable "min_elb_capacity" {
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
  default     = 0
}

variable "wait_for_elb_capacity" {
  description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over `min_elb_capacity` behavior"
  default     = false
}

variable "protect_from_scale_in" {
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events"
  default     = false
}

variable "service_linked_role_arn" {
  type        = "string"
  description = "The ARN of the service-linked role that the ASG will use to call other AWS services"
  default     = ""
}

variable "autoscaling_policies_enabled" {
  type        = "string"
  default     = "true"
  description = "Whether to create `aws_autoscaling_policy` and `aws_cloudwatch_metric_alarm` resources to control Auto Scaling"
}

variable "scale_up_cooldown_seconds" {
  type        = "string"
  default     = "300"
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
}

variable "scale_up_scaling_adjustment" {
  default     = 1
  description = "The number of instances by which to scale. `scale_up_adjustment_type` determines the interpretation of this number (e.g. as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity"
}

variable "scale_up_adjustment_type" {
  type        = "string"
  default     = "ChangeInCapacity"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are `ChangeInCapacity`, `ExactCapacity` and `PercentChangeInCapacity`"
}

variable "scale_up_policy_type" {
  type        = "string"
  default     = "SimpleScaling"
  description = "The scalling policy type, either `SimpleScaling`, `StepScaling` or `TargetTrackingScaling`"
}

variable "scale_down_cooldown_seconds" {
  type        = "string"
  default     = "300"
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
}

variable "scale_down_scaling_adjustment" {
  default     = -1
  description = "The number of instances by which to scale. `scale_down_scaling_adjustment` determines the interpretation of this number (e.g. as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity"
}

variable "scale_down_adjustment_type" {
  type        = "string"
  default     = "ChangeInCapacity"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are `ChangeInCapacity`, `ExactCapacity` and `PercentChangeInCapacity`"
}

variable "scale_down_policy_type" {
  type        = "string"
  default     = "SimpleScaling"
  description = "The scalling policy type, either `SimpleScaling`, `StepScaling` or `TargetTrackingScaling`"
}

variable "cpu_utilization_high_evaluation_periods" {
  type        = "string"
  default     = "2"
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "cpu_utilization_high_period_seconds" {
  type        = "string"
  default     = "300"
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_high_threshold_percent" {
  type        = "string"
  default     = "90"
  description = "The value against which the specified statistic is compared"
}

variable "cpu_utilization_high_statistic" {
  type        = "string"
  default     = "Average"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`"
}

variable "cpu_utilization_low_evaluation_periods" {
  type        = "string"
  default     = "2"
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "cpu_utilization_low_period_seconds" {
  type        = "string"
  default     = "300"
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_low_threshold_percent" {
  type        = "string"
  default     = "10"
  description = "The value against which the specified statistic is compared"
}

variable "cpu_utilization_low_statistic" {
  type        = "string"
  default     = "Average"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`"
}

variable "bootstrap_extra_args" {
  type        = "string"
  default     = ""
  description = "Passed to the bootstrap.sh script to enable --kublet-extra-args or --use-max-pods."
}

variable "aws_iam_instance_profile_name" {
  type        = "string"
  default     = ""
  description = "The name of the existing instance profile that will be used in autoscaling group for EKS workers. If empty will create a new instance profile."
}

variable "workers_security_group_id" {
  type        = "string"
  default     = ""
  description = "The name of the existing security group that will be used in autoscaling group for EKS workers. If empty, a new security group will be created"
}

variable "use_existing_security_group" {
  type        = "string"
  description = "If set to `true`, will use variable `workers_security_group_id` to run EKS workers using an existing security group that was created outside of this module, workaround for errors like `count cannot be computed`"
  default     = "false"
}

variable "additional_security_group_ids" {
  type        = "list"
  default     = []
  description = "Additional list of security groups that will be attached to the autoscaling group"
}

variable "use_existing_aws_iam_instance_profile" {
  type        = "string"
  description = "If set to `true`, will use variable `aws_iam_instance_profile_name` to run EKS workers using an existing AWS instance profile that was created outside of this module, workaround for error like `count cannot be computed`"
  default     = "false"
}

variable "workers_role_policy_arns" {
  type        = "list"
  default     = []
  description = "List of policy ARNs that will be attached to the workers default role on creation"
}

variable "workers_role_policy_arns_count" {
  type        = "string"
  default     = "0"
  description = "Count of policy ARNs that will be attached to the workers default role on creation. Needed to prevent Terraform error `count can't be computed`"
}


variable "mixed_type" {
  type        = "string"
  default     = "true"
}

#https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html#instances_distribution
# Empty spot max price will default to current spot price
variable "autoscaling_configs" {
  default = {
      on_demand_base_capacity = 0
      spot_instance_pools = 1
      health_check_grace_period = 300
      on_demand_percentage_above_base_capacity = 10
      spot_max_price = ""
  }
}

variable "autoscaling_instances" {
  default = {
      supported_instance_1 = "t3.medium"
      supported_instance_2 = "t2.medium"
      supported_instance_3 = "t3.large"
  }
}
