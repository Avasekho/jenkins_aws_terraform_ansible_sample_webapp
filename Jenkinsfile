pipeline {
  agent { label 'jenkins-agent' }
  tools {
    terraform 'Terraform'
    tool name: 'Ansible', type: 'org.jenkinsci.plugins.ansible.AnsibleInstallation'
  }
  environment {
    AWS_ACCESS_KEY_ID = credentials('34d2a98c-ee5a-4a65-939e-44a8a9c18d97')
    AWS_SECRET_ACCESS_KEY = credentials('34d2a98c-ee5a-4a65-939e-44a8a9c18d97')
  }
  stages {
    stage ('Terraform init') {
      steps {
    sh 'terraform init'
    }
    }

    stage ('Terraform plan') {
      steps {
    sh 'terraform plan'
    }
    }

    stage ('Terraform appy') {
      steps {
    sh 'terraform apply'
    }
    }

    stage ('Ansible provisioning') {
      steps {
    ansiblePlaybook installation: 'Ansible', playbook: 'provision-playbook.yml'
    }    
    }
  }
}