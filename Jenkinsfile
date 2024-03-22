pipeline {
  agent { label 'prod-server' }
  stages {
    stage('checkout') {
      steps {
        sh 'rm -rf  hello-world-war'
        sh 'git clone https://github.com/Ahmsagar401/hello-world-war.git'
      }
    }
    
    stage('build') {
      agent { label 'prod-server' }
      steps {
        sh 'echo "inside build check"' 
        dir("hello-world-war") {
            sh 'echo "inside directory"'
            sh 'docker build -t tcat-image1:${BUILD_NUMBER} .'
          }
      }
    }
    
    stage('Push Image to Docker hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: '6208e6bc-1e1e-48b2-b8fa-4f4708d4effe', passwordVariable: 'password', usernameVariable: 'username')]) {
        sh 'docker login -u $username -p $password'
        sh 'echo "login succefull"'
        sh 'docker tag tcat-image1:${BUILD_NUMBER} ashish401/private-repo:${BUILD_NUMBER}'
        sh 'docker push ashish401/private-repo:${BUILD_NUMBER}'
        sh 'echo "Image pushed to docker hub"'
        }
      }
    }
    
    stage('pull and deploy') {
      parallel {
        stage('deploy to slave1') {
          agent { label 'slave1' }
          steps {
            sh 'docker login -u $username -p $password'
            sh 'docker pull ashish401/private-repo:${BUILD_NUMBER}'
            sh 'docker run -d -p 8081:8080 --name tcat-container1 tcat-image1:${BUILD_NUMBER}'
          }
        }
        stage('deploy to slave2') {
          agent { label 'slave2' }
          steps {
            sh 'docker login -u $username -p $password'
            sh 'docker pull ashish401/private-repo:${BUILD_NUMBER}'
            sh 'docker run -d -p 8081:8080 --name tcat-container2 tcat-image1:${BUILD_NUMBER}'
          }
        }
      }
    }
  }
}
