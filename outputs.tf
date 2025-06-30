output "instance_public_ip" {
  value = aws_instance.ec2.public_ip
}

output "key_name" {
  value = aws_key_pair.generated_key.key_name
}

output "private_key_path" {
  value = local_file.private_key_pem.filename
}


