## Simple Continues Integration Pipeline with Jenkins and Ansible
#### There is a saying - best devops use the worse laptopx.
Well, probably, I am not the best but I use pretty slow notebook and run almost everything in the cloud.
##### The goal is to setup Jenkins to poll Github, test the latest commit and deploy the app if everyhing is ok
The application is a simple Python Flask hello world. See it at: [demo app](https://github.com/dmitriko/demoapp)
- create 2 repos, one for ops another one for app
- generate ssh keys to use as deployment keys for repos
- create a password file to use with Ansible Vault
- script that setup a local env
  - python3 venv
  - install ansible
- create a simplest python app with one unit test
- create a jenkinsfile and upload it to repo
  - poll repo
  - build docker
  - run tests
  - docker push
  - run ansible playbook
    - docker pull
    - start container
    - fix nginx config and reload
    - test availability
    - kill previous container
- launch ops droplet
  - put private and public ssh keys (that are deployment keys)
  - install docker
  - docker login
  - upload jenkins job
  - create jenkins user with uid 1000
  - install jenkins as docker container making sure job is inside
  - install ansible
  - upload deployment playbook
- launch app droplet
  - install docker
  - docker login
  - authkeys from ops host
  - install nginx
  - setup lets encrypt


* staff
Jenkins.instance.pluginManager.plugins.each{
  plugin -> 
    println ("${plugin.getShortName()}:${plugin.getVersion()}")
}

node {
   stage('Pulling from GitHub') { 
     git 'git@github.com:dmitriko/demoapp.git'
     
   }
   stage('Build Docker image') {
     sh "pwd"
     
   }
   
}
