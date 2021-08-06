pipeline {

  agent none

  environment {
    DOCKER_IMAGE = "linhvv2/jenkins-docker"
  }

  stages {
    stage("Test") {
      agent {
          docker {
            image 'ubuntu:latest'
          }
      }
      steps {
        sh "lsb_release -a "
      }
    }

    stage("build") {
      
      steps {
        withDockerRegistry(credentialsId: 'Docker-hub', url: 'https://index.docker.io/v1/).') 
        sh "docker build -t ${DOCKER_IMAGE}:v10 . "
       
        withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh 'echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin'
            sh "docker push ${DOCKER_IMAGE}:V10"
            sh "docker push ${DOCKER_IMAGE}:latest"
        }

        //clean to save disk
        
        sh "docker image rm ${DOCKER_IMAGE}:latest"
      }
    }
  }

  post {
    success {
      echo "SUCCESSFUL"
    }
    failure {
      echo "FAILED"
    }
  }
}
