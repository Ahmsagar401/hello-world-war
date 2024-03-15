pipeline {
    agent { label 'slave1' }
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
                    sh' docker build -t tcat-image1:1.0 .'
                }    
            }
        }
        stage('deploy') {
            steps {
                    sh 'docker rm -f tcat-container'
                    sh 'docker run -d -p 8081:8080 --name tcat-container tcat-image1:1.0'
            }
        }
    }
}
