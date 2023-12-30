variable "public_cidr" {
  type = list(string)
  description = "public cidr value"
  default = ["10.0.1.0/26", "10.0.2.0/26"]
}

variable "private_cidr" {
    type = list(string)
    description = "private cidr value"
    default = ["10.0.3.0/26", "10.0.4.0/26"]
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-east-1a", "us-east-1b"]
}