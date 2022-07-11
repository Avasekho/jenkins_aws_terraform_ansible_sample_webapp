pipeline {
  agent aws-jenkins-agent

  tools {
    terraform 'terraform'
  }
  environment {
    AWS_ACCESS_KEY_ID = credentials('34d2a98c-ee5a-4a65-939e-44a8a9c18d97')
    AWS_SECRET_ACCESS_KEY = credentials('34d2a98c-ee5a-4a65-939e-44a8a9c18d97')
  }
  stages {
    stage ('Terraform init') {
    sh 'terraform init'
    }

    stage ('Terraform plan') {
    sh 'terraform plan'
    }

    stage ('Terraform appy') {
    sh 'terraform apply'
    }

    stage ('Ansible provision') {
    ansiblePlaybook installation: 'Ansible', playbook: 'provision-playbook.yml'
    }    
    }

}