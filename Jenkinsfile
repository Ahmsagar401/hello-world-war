pipeline {
    agent any
stages {
        stage('checkout') {
            steps {
                sh 'rm -rf  hello-world-war'
                sh 'git clone https://github.com/Ahmsagar401/hello-world-war.git'
            }
        }
        stage('build') {
            steps {
                sh 'echo "inside build check"'
                dir("hello-world-war") {
                    sh'echo "inside directory"'
                    sh' docker build -t tomcat-image1:1.0'
                }    
            }
        }
        stage('deploy') {
            steps {
                    sh 'docker rm -f tomcat-container'
                    sh 'docker run -d -p 8080:8080 --name tomcat-container tomcat-image1:1.0'
            }
        }
    }
}
