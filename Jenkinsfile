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
                        sh '''
                            terraform init
                            terraform get -update
                            terraform plan -no-color
                        '''     
                        input(message: 'Apply now?', ok: 'Yes')   
                        sh 'terraform apply --no-color --auto-approve'
                    }
                }
            }
        }
    }
}