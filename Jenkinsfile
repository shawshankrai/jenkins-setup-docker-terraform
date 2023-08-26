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

        stage('Save Cred') {
            steps {
              sh'mkdir -p creds'
              sh 'echo $SVC_ACCOUNT_KEY | base64 -d > ./creds/serviceaccount.json'  
            }
        }

        stage('Terraform deploy') {
            steps {
              dir('create-bucket') {
                  sh'ls -la'
                  sh 'terraform fmt'
                  sh 'terraform init'
                  sh 'terraform apply --auto-approve'
              }
            }
        }
    }
}