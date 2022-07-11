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
      ansiblePlaybook become: true, becomeUser: 'ubuntu', credentialsId: 'ansible-ssh', installation: 'Ansible', inventory: 'inventory', playbook: 'provision-playbook.yml'
    }    
    }
  }
}