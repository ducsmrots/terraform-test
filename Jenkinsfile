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
                      export AWS_ACCESS_KEY_ID="${AWS_CREDS_USR}"
                    export AWS_SECRET_ACCESS_KEY="${AWS_CREDS_PSW}"
                      terraform init
                      terraform validate
                      terraform plan -out=tfplan
                      terraform apply -auto-approve tfplan
                      terraform destroy -auto-approve tfplan
                      '''
                    }
                }
            }
        }
    }
}
