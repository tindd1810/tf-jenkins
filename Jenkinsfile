pipeline {

    agent any
    tools {
          terraform 'my-terraform'
    }
    stages {
        stage ('Checking') {
        steps {
            sh 'terraform --version'
            dir("vpc") {
            sh 'terraform plan'
            }
        }
        }
    }
}