pipeline {
    agent {
        label 'terraform'
    }

    environment {
        AWS_ACCESS_KEY_ID = ''
        AWS_SECRET_ACCESS_KEY = ''
    }
    stages {

        stage('Setup AWS Credentials') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'aws-credentials', 
                        usernameVariable: 'AWS_ACCESS_KEY_ID', 
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        env.AWS_ACCESS_KEY_ID = "${AWS_ACCESS_KEY_ID}"
                        env.AWS_SECRET_ACCESS_KEY = "${AWS_SECRET_ACCESS_KEY}"
                    }
                }
            }
        }
        stage('terraform deploy') {
            steps {
                // Your build steps here
                ansiColor('xterm') {
                    container('terraform') {
                      sh 'terraform init'
                      sh 'terraform validate'
                      sh 'terraform -var "aws_access_key=${AWS_ACCESS_KEY_ID} plan -out=tfplan'
                      sh 'terraform -var "aws_access_key=${AWS_ACCESS_KEY_ID} apply'
                      sh 'terraform destroy'
                    }
                }
            }
        }
    }
}
