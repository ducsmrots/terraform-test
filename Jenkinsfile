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
                container('terraform') {
                  sh 'terraform init'
                  sh 'terraform validate'
                  sh 'terraform plan -out=tfplan'
                  sh 'terraform apply'
                  sh 'terraform destroy'
                }
            }
        }
    }
}
