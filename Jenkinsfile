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
    parameters {
        choice choices: ['Apply', 'Delete', 'CreateAgent'], name: 'ApplyOrDelete'
    }

    stages {
        stage ('Apply') {
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

        stage ('CreateAgent') {
        when {
            expression { params.ApplyOrDelete == 'CreateAgent'}
        }
        steps {
                sh 'terraform --version'
                dir("jenkins-node") {
                    withCredentials([aws(credentialsId: 'aws-creds')]) { 
                        sh '''
                            terraform init -no-color
                            terraform get -update
                            terraform plan -no-color
                        '''     
                        input(message: 'Apply now?', ok: 'Yes')   
                        sh 'terraform apply -no-color -auto-approve'
                    }
                }
            }
        }
    }
}