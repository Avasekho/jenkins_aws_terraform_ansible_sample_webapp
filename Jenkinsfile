pipeline {
  agent aws-jenkins-agent

  tools {
    terraform 'terraform'
  }
  stages {
    stage ('Terraform init') {
    sh 'terraform init'
    }

    stage ('Terraform plan') {
    sh 'terraform plan'
    }

    stage ('Terraform appy') {
    withCredentials([<object of type com.cloudbees.jenkins.plugins.awscredentials.AmazonWebServicesCredentialsBinding>]) {
    sh 'terraform apply'
    } 
    }

    stage ('Ansible provision') {
    ansiblePlaybook installation: 'Ansible', playbook: 'provision-playbook.yml'
    }    
    }

}