pipeline {

    agent {
        label 'amz-linux' 
    }
    tools {
          terraform 'my-terraform'
    }
    stages {
        stage ('Checking') {
        steps {
            sh 'terraform --version'
            dir("vpc") {
            sh 'aws --version'
            }
        }
        }
    }
}