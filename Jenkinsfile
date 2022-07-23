pipeline {

    agent any
    tools {
          terraform 'my-terraform'
    }
    environment {
        AWS_DEFAULT_REGION = "ap-southeast-1"
    }
    parameters {
        choice choices: ['Apply', 'Delete', 'CreateAgent', 'DeleteAgent'], name: 'ApplyOrDelete'
    }

    stages {
        stage ('Apply') {
        agent {
            label 'amz-linux' 
        }
        when {
            expression { params.ApplyOrDelete == 'Apply'}
        }
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
                        sh 'terraform apply -no-color -auto-approve'
                    }
                }
                dir("services") {
                    withCredentials([aws(credentialsId: 'aws-creds')]) { 
                        sh '''
                            terraform init
                            terraform get -update
                            terraform plan -no-color
                        '''     
                        input(message: 'Apply now?', ok: 'Yes')   
                        sh 'terraform apply -no-color -auto-approve'
                    }
                }
            }
        }

        stage ('Delete') {
        agent {
            label 'amz-linux' 
        }
        when {
            expression { params.ApplyOrDelete == 'Delete'}
        }
        steps {
                sh 'terraform --version'

                dir("services") {
                    withCredentials([aws(credentialsId: 'aws-creds')]) { 
                        sh '''
                            terraform init
                            terraform get -update
                            terraform plan -no-color
                        '''     
                        input(message: 'Apply now?', ok: 'Yes')   
                        sh 'terraform destroy -no-color -auto-approve'
                    }
                }

            }
        }

    }
}