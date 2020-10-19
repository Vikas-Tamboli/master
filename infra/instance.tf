esource "aws_security_group" "test_sg" {
	
	description ="allowing ssh and http traffic"
        vpc_id = var.vpc_id

	ingress {
	from_port = var.ssh_port
	to_port = var.ssh_port
	protocol = "tcp"
	cidr_blocks = [var.ssh_cidr]
	}

	ingress {
        from_port = var.http_port
        to_port = var.http_port
        protocol = "tcp"
        cidr_blocks = [var.cidr]
        }
	
	egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = [var.cidr]
        }
	tags={
		Name = var.sg_tag
}

}


#********creating ec2-instance***********

resource "aws_instance" "shubham" {
        ami = var.ami
        instance_type = var.instance_type  
        vpc_security_group_ids = ["${aws_security_group.test_sg.id}"]
        key_name = var.key

        user_data = <<-EOF
                #! /bin/bash
                sudo yum install httpd -y
                sudo systemctl start httpd.service
                sudo systemctl enable httpd.service
                echo "hello brother from $(hostname)" >> /var/www/html/index.html
                EOF



        tags = {
            Name = var.ins_tag
        }
}

