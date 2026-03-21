# ─────────────────────────────────────────
# Maplewood Bakery — Variables
# ─────────────────────────────────────────

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "admin_ip" {
  description = "Your IP address for SSH access — format: x.x.x.x/32"
  type        = string
  # Go to whatismyip.com and paste your IP here as x.x.x.x/32
}
