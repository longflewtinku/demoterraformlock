output "webpage" {
    value = "http://${aws_instance.myownec2.public_ip}:80"
  
}