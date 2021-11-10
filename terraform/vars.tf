variable "AWS_ACCESS_KEY" {
  type        = string
  description = "aws access key"
}

variable "AWS_SECRET_KEY" {
  type        = string
  description = "aws secret key"
}


variable "AWS_REGION" {
  type        = string
  default     = "us-east-2"
  description = "aws region"
}
variable "AWS_USERS" {
  type        = list
  description = "list user to create"
}
