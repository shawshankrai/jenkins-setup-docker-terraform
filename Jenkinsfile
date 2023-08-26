pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:light'
            args '--entrypoint='
        }
    }

    environment {
        SVC_ACCOUNT_KEY = credentials('terraform-auth')
        SUB_MODULE = '/create-bucket'

    }

    stages {

        stage('Checkout') {
            steps {
              checkout([$class: 'GitSCM', 
                branches: [[name: '*/main']],
                extensions: [
                    [$class: 'SparseCheckoutPaths', 
                    sparseCheckoutPaths:[[$class:'SparseCheckoutPath', path:'/create-bucket']]]
                    ],
                userRemoteConfigs: [[url: 'https://github.com/shawshankrai/google-data-eng.git']]])
          }
        }

        stage('mkdir') {
            steps {
              sh'mkdir -p creds'
              sh 'echo $SVC_ACCOUNT_KEY | base64 -d > ./creds/serviceaccount.json'  
            }
        }

        stage('change dir') {
            steps {
              dir('create-bucket') {
                  sh'ls -la'
              }
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