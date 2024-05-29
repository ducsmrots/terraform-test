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
                      terraform init'
                      terraform validate
                      terraform -var aws_access_key=\${AWS_ACCESS_KEY_ID} plan -out=tfplan
                      terraform -var aws_access_key=\${AWS_ACCESS_KEY_ID} apply
                      sh terraform destroy
                      '''
                    }
                }
            }
        }
    }
}
