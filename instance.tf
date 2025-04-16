# Creating EC2 instance
resource "aws_instance" "vm_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.aws_key_pair_name
  subnet_id              = aws_subnet.public_subnets[1].id
  vpc_security_group_ids = [aws_security_group.launch-wizard-1.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  user_data = templatefile("init.sh.tpl", {
    model_zip = basename(var.model_path),
    s3_bucket = var.s3_bucket
  })

  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_size           = 128
    volume_type           = "gp3"
    snapshot_id           = "snap-00576a29f5cb985fe"
    iops                  = 3000
    throughput            = 125
    encrypted             = false
    delete_on_termination = true
  }

  associate_public_ip_address = true

  tags = {
    Name = "pest-aws"
  }
}