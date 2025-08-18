data "aws_vpc" "myalredayvpc" {
  default = true
}

data "aws_security_group" "mycloudsg" {
  filter {
    name   = "group-name"
    values = ["openall"]
  }
}

data "aws_ami" "myami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-minimal-20250625"]
  }

}
resource "aws_key_pair" "myterraformownkey" {
  key_name   = "myownadvec2key1"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "myownec2" {
  ami                    = data.aws_ami.myami.id
  key_name               = aws_key_pair.myterraformownkey.key_name
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.mycloudsg.id]
  tags = {
    Name = "myadvec2"
  }
}

resource "null_resource" "changes" {
  triggers = {
    build_id = "1.3"
  }
    connection {
    type = "ssh"
    user = "ubuntu"
    host = aws_instance.myownec2.public_ip
    private_key = file("~/.ssh/id_ed25519")

  }
  provisioner "file" {
    source = "./test.sh"
    destination = "/home/ubuntu/test.sh"
    
  }
  provisioner "remote-exec" {
    inline = [ "sudo chmod +x /home/ubuntu/test.sh",
               "sh /home/ubuntu/test.sh" ]
  }
  
}


   
   




   
