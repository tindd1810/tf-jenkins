pipeline {

    agent {
        label 'amz-linux' 
    }
    tools {
          terraform 'my-terraform'
    }
    environment {
        AWS_DEFAULT_REGION = "ap-southeast-1"
    }
    stages {
        stage ('Checking') {
        steps {
            
            sh 'terraform --version'
            dir("vpc") {
                withCredentials([aws(credentialsId: 'aws-creds')]) {
                    sh 'aws --version'
                    sh 'aws s3 ls'   
                    sh 'terraform plan'        
                }
            }
        }
        }
    }
}