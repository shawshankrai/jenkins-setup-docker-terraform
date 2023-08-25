pipeline {
    agent { dockerfile true }
    stages {
        stage('Git checkout') {
           steps{
                git branch: 'main', url: 'https://github.com/shawshankrai/google-data-eng.git'
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