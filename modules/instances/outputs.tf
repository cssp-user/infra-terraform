output "jenkinsserver_publicip" {
value = "${aws_instance.jenkinsserver.public_ip}"
}
