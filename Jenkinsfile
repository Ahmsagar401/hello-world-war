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
}

   stage('Helm Deploy') {
            steps {
                // Authenticate with AWS using IAM credentials stored in Jenkins
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credentials',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh "aws eks --region eu-west-2 update-kubeconfig --name my-eks-cluster"
                    echo 'Deploying to Kubernetes using Helm'
                    // Deploy Helm chart to Kubernetes cluster
                    sh "helm upgrade tomcat /var/lib/jenkins/workspace/job1/hello-world-war --install --namespace hello-world-war --set image.tag=$BUILD_NUMBER --dry-run"
                    sh "helm upgrade tomcat /var/lib/jenkins/workspace/job1/hello-world-war --install --namespace hello-world-war --set image.tag=$BUILD_NUMBER"
                }
            }
        }
    }
}
  
