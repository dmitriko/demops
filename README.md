## Simple Continues Integration Pipeline with Jenkins and Ansible
### The key point of this setup - it is One Click installation,
once you have ansible setup on your laptop it is a matter of one command to install everything.
After it complets you just commit your changes and after the tests they appear at the application endpoint.
#### There is a saying - best devops use the worse laptop.
Well, probably, I am not the best but I use pretty slow notebook and run almost everything in the cloud.
##### The goal is to setup Jenkins to poll Github, test the latest commit and deploy the app if everyhing is ok
The application is a simple Python Flask hello world. See the souce code at: [demo app](https://github.com/dmitriko/demoapp)
##### The most challenge part was to setup Jenkins in container and make it fully automatically.
###### On my laptop:
- Python3 is installed
- Virtual env is created
- Password file with password for Ansible Vault is created.
- Ansible is installed
- Digital Ocean token accuired and put in secrets.yaml
- Docker Hub token is accuired
- New SSH keys generated and added to demo app repo as deployment keys. id_rsa is encrypted by Ansible Vault
###### Main Playbook that setups everything is [here](https://github.com/dmitriko/trgops/blob/master/site.yaml)
- create 2 Digital Ocean droplets and register DNS record for one of them at demapp.politerobots.com,
it will be an application host  
- on Application host it does: 
	- let Jenkins to login via ssh
	- let docker pull to work
	- let Ansible to manage docker
	- setup nginx with firewall access    

[_playbook_](https://github.com/dmitriko/trgops/blob/master/roles/app/tasks/main.yaml)
- on Jenkins host it does: 
	- create jenkins user
	- setup Ansible 
	- put deployment jenkins job, see it [there](https://github.com/dmitriko/trgops/blob/master/roles/jenkins/files/deploy_job_config.xml)
	- fix docker push/pull
	- build and run Jenkins container from this [Dockerfile](https://github.com/dmitriko/trgops/blob/master/roles/jenkins/files/docker_image/Dockerfile)

[_playbook_](https://github.com/dmitriko/trgops/blob/master/roles/jenkins/tasks/main.yaml)


##### Kubernetes
Whatever we like or not K8S is the standard environment to run applications these days. I like it because I had a lot of problems with different approaches like Docker Sware, docker-compose etc. Usually, K8S just works for the statless application. I believe databases should be running as dedicated services by cloud providers.
