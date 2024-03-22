pipeline {
  agent { label 'slave1' }
  stages {
    stage('checkout') {
      agent { label 'prod-server' }
      steps {
        sh 'rm -rf  hello-world-war'
        sh 'git clone https://github.com/Ahmsagar401/hello-world-war.git'
      }
    }
    
    stage('build') {
      steps {
        sh 'echo "inside build check"'
        sh 'docker build -t tcat-image1:${BUILD_NUMBER} .'
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
            withCredentials([usernamePassword(credentialsId: '6208e6bc-1e1e-48b2-b8fa-4f4708d4effe', passwordVariable: 'password', usernameVariable: 'username')]) {
            sh 'docker login -u $username -p $password'
            sh 'docker pull ashish401/private-repo:${BUILD_NUMBER}'
            sh 'docker run -d -p 8082:8080 --name tcat-container3 ashish401/private-repo:${BUILD_NUMBER}'
            }
          }
        }
        stage('deploy to slave2') {
          agent { label 'slave2' }
          steps {
            withCredentials([usernamePassword(credentialsId: '6208e6bc-1e1e-48b2-b8fa-4f4708d4effe', passwordVariable: 'password', usernameVariable: 'username')]) {
            sh 'docker login -u $username -p $password'
            sh 'docker pull ashish401/private-repo:${BUILD_NUMBER}'
            sh 'docker run -d -p 8083:8080 --name tcat-container4 ashish401/private-repo:${BUILD_NUMBER}'
            }
          }
        }
      }
    }
  }
}
