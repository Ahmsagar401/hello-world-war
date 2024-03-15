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
                sh 'echo "inside build check" 
                dir("hello-world-war") {
                    sh'echo "inside directory"
            }
        }
        stage('deployment') {
            steps {
                    sh 'ssh root@172.31.28.235'
                    sh 'scp /home/slave1/workspace/pipelinejob_helloworld/target/hello-world-war-1.0.0.war root@172.31.28.235:/opt/apache-tomcat-8.5.98/webapps/'
            }
        }
    }
}
