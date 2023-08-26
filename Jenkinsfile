pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:light'
            args '--entrypoint='
        }
    }

    environment {
        SVC_ACCOUNT_KEY = credentials('terraform-auth')
    }

    stages {
        stage('Git checkout') {
           steps{
                checkout scmGit(
                    branches: [[name: 'main']],
                    userRemoteConfigs: [[url: 'https://github.com/shawshankrai/google-data-eng.git']]
                )
                sh 'cd create-bucket'
                sh 'mkdir -p creds' 
                sh 'echo $SVC_ACCOUNT_KEY | base64 -d > ./creds/serviceaccount.json'
            }
        }

        stage('terraform format check') {
            steps{
                sh 'terraform fmt'
            }
        }

        stage('terraform Init') {
            steps{
                sh 'terraform init'
            }
        }

        stage('terraform apply') {
            steps{
                sh 'terraform apply --auto-approve'
            }
        }
    }
}