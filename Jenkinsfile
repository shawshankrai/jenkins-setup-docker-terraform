pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:light'
            args '--entrypoint='
        }
    }

    environment {
        SUB_DIR = "create-bucket"
        SUB_MODULE = "/${env.SUB_DIR}"
        SVC_ACCOUNT_KEY = credentials('terraform-auth')
    }

    stages {

        stage('Checkout') {
            steps {
              checkout([$class: 'GitSCM', 
                branches: [[name: '*/main']],
                extensions: [
                    [$class: 'SparseCheckoutPaths', 
                    sparseCheckoutPaths:[[$class:'SparseCheckoutPath', path:"${SUB_MODULE}"]]]
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
              dir("${env.SUB_DIR}") {
                  sh'ls -la'
                  sh 'terraform fmt'
                  sh 'terraform init'
                  sh 'terraform apply --auto-approve'
              }
            }
        }
    }
}