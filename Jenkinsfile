pipeline {
  agent {
    label 'jenkins-agent'
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
        withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
        sh 'terraform apply -auto-approve'
    } 
    }
    }

    stage ('Ansible provisioning') {
      steps {
      sh 'ansible-playbook provision-playbook.yml'
    }    
    }
  }
}