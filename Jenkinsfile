pipeline {
    agent {
        label 'terraform'
    }

    environment {
        AWS_CREDS = credentials('aws-credentials')
    }
    stages {
        stage('terraform deploy') {
            steps {
                // Your build steps here
                ansiColor('xterm') {
                    container('terraform') {
                      sh  '''
                      terraform init
                      terraform validate
                      terraform plan -var "aws_access_key=${AWS_CREDS_USR}" -var "aws_secret_key=${AWS_CREDS_PSW}"  plan -out=tfplan
                      terraform apply -var "aws_access_key=${AWS_CREDS_USR}" -var "aws_secret_key=${AWS_CREDS_PSW}"
                      terraform destroy
                      '''
                    }
                }
            }
        }
    }
}
