pipeline {
    agent any


stages {
    stage('Clone repository') {
        steps {
            git branch: 'developELA', url: 'https://github.com/lakhalEya/SpringDataJPA-CrudRepo.git'
        }
    }
    
    stage('Verify environment') {
        steps {
            sh 'mvn --version'
            sh 'java --version'
        }
    }
    stage('Build and Run Services') {
      steps {
        sh 'docker-compose --version'
        sh 'docker-compose build'
        sh 'docker-compose up -d --no-recreate'
      }
    }
    
    stage('Build') {
        steps {
            sh 'mvn clean package'
        }
    }
    
    stage('Unit tests') {
        steps {
            sh 'mvn test'
        }
    }
    
    stage('Deploy') {
        steps {
            sh "mvn deploy -DskipTests -DaltDeploymentRepository=esprit-spring-ioc-1.0-releases::default::http://192.168.33.10:8081/repository/Spring_IOC/ -Dusername=admin -Dpassword=nexus"
        }
    }
   
    /*stage('Static code analysis') {
      steps {
        sh "mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=sonar -Dsonar.host.url=http://192.168.33.10:9000"
      }
    }*/
    
  stage("Build Docker image") {
      steps {
        script {
          docker.build("lkhleya/docker_devops_rep")
        }
      }
    }
    
    stage("Login to Docker Hub") {
      steps {
        script {
          docker.withRegistry("https://index.docker.io/v1/", "docker") {
            docker.login(username: admin, password: dockerhub)
          }
        }
      }
    }
    
    stage("Push Docker image to Docker Hub") {
      steps {
        script {
          docker.withRegistry("https://index.docker.io/v1/", "docker") {
            docker.image("lkhleya/docker_devops_rep:tagname").push()
          }
        }
      }
    }

}

        /*

        





     }

    post {
        failure {
            mail to: 'lkhleya@gmail.com',
            subject: "Build failed in ${currentBuild.fullDisplayName}",
            body: "Something is broken with ${env.BUILD_URL}"
        }
        success {
            mail to: 'lkhleya@gmail.com',
            subject: "Build succeeded in ${currentBuild.fullDisplayName}",
            body: "Everything is working fine with ${env.BUILD_URL}"
        }
    }*/
}
