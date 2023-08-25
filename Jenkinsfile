pipeline {
    agent { dockerfile true }

    environment {
        GOOGLE_IMPERSONATE_SERVICE_ACCOUNT = "terraform-gcp@terraform-gcp-382215.iam.gserviceaccount.com"
    }
    
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
            steps{
                sh 'terraform apply --auto-approve'
            }
        }
    }
}