Final project
"Deploy static website on AWS"

Project demo on youtube - https://youtu.be/AmFW0Lzr5mk 
List of commands & step-by-step tutorial - https://github.com/akselay/EPAM-DevOps-L1-course/FinalProject

Instruments used:
	AWS
	Ansible
	Docker
	Git
	Jenkins
	httpd

Instances:
	Local - Host with Git
	AWS - Instance 1 - Ansible
	AWS - Instance 2 - Jenkins
	AWS - Instance 3 - Webserver

Artifact:
	index.html - static web page - https://github.com/akselay/testweb.git
	
How it works:
	Creates 3 EC2 instanses: Ansible, Jenkins and Webserver
	Ansible is used to install Docker on Jenkins and Webserver
	Jenkins and Webserver run in Docker containers
	Webserver installs Git and runs httpd (in container)
	User makes changes to index.html on a local machine and makes git commit & push
	GitHub webhook transfers call to Jenkins
	Jenkins runs a job with content deployment to Webserver and places it in running container
	
Result:
	We can see updated website page on Webserver's public IP 
	It updates every time we make git commit & push
