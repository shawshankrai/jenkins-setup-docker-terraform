pipeline {
    agent { dockerfile true }
    stages {
        stage('Deploy') {
            steps {
                withCredentials([file(credentialsId: 'key-sa', variable: 'SECRET_JSON')]) {
                    sh '''
                    set +x
                    HOME=$WORKSPACE
                    gcloud auth activate-service-account --key-file $SECRET_JSON
                    gcloud config set project terraform-gcp-382215
                    gcloud --version
                    '''
                }
            }
        }

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
            steps {
                withCredentials([file(credentialsId: 'key-sa', variable: 'SECRET_JSON')]) {
                    sh 'terraform apply --auto-approve'
                }
            }
        }
    }
}