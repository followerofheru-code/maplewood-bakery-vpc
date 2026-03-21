# ─────────────────────────────────────────
# Maplewood Bakery — Outputs
# ─────────────────────────────────────────

output "vpc_id" {
  description = "Maplewood VPC ID"
  value       = aws_vpc.maplewood_vpc.id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = aws_subnet.private_subnet.id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.maplewood_igw.id
}

output "web_security_group_id" {
  description = "Web server security group ID"
  value       = aws_security_group.web_sg.id
}
