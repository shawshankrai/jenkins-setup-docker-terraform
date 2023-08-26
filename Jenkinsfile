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
                git branch: 'main', url: 'https://github.com/shawshankrai/google-data-eng.git'
                sh 'mkdir -p creds' 
                sh 'base64 $SVC_ACCOUNT_KEY > ./creds/serviceaccount.json'
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