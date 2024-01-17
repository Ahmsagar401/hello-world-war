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
                sh 'mvn --version' 
                sh 'mvn clean install'
            }
        }
        stage('deployment') {
            steps {
                sh 'ssh root@172.31.28.235'
                sh 'cp /home/slave1/workspace/pipelinejob_helloworld/target/hello-world-war-1.0.0.war /opt/apache-tomcat-8.5.98/webapps/'
            }
        }
    }
}
