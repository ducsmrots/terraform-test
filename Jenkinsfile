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
                      terraform plan -out=tfplan -var "aws_access_key_id=${AWS_CREDS_USR}" -var "aws_secret_access_key=${AWS_CREDS_PSW}"
                      terraform apply -var "aws_access_key_id=${AWS_CREDS_USR}" -var "aws_secret_access_key=${AWS_CREDS_PSW} -auto-approve tfplan"
                      terraform destroy
                      '''
                    }
                }
            }
        }
    }
}
