output "ssh_login" {
  description = "Command used to log into EC2 via ssh"
  value       = format("%s%s%s%s", "ssh -i ~/.ssh/", var.aws_key_pair_name, ".pem ubuntu@", aws_instance.vm_instance.public_ip)
}