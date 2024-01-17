pipeline {
    agent { label 'slave1' }
stages {
        stage('checkout') {
            steps {
                sh 'git clone https://github.com/Ahmsagar401/hello-world-war/'
            }
        }
        stage('build') {
            steps {
                sh 'mvn --version' 
                sh 'mvn clean install'
            }
        }
    }
}
