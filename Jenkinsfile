pipeline {
  agent {



  }
  environment {
    DOCKERHUB_CREDS = credentials('')
  }


      stages {
      stage ('Ensure Docker is running') {
        steps {
          sh 'service docker start'
          sh 'service docker status'
        }
        }
      }