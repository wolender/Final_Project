pipeline {
    agent any


    stages {
        stage('Pull') {
            steps {
                git branch: 'main', url:'https://github.com/wolender/Final_Project.git'
            }
        }

        stage('Format') {
            steps{
                dir('terraform') {
                    sh 'terraform fmt'
                }
               
            }
        }

        stage('Init') {
            steps{
                dir('terraform') {
                    sh 'terraform init -force-copy'
                }
               
            }
        }

        stage('Validate') {
            steps{
                dir('terraform') {
                    sh 'terraform validate'
                }
               
            }
        }

        stage('Plan') {
            steps{
                dir('terraform') {
                        sh 'terraform plan'
                    }                    
                }        
        }

        stage('Apply') {
            steps{
                dir('terraform') {

                    sh 'terraform apply -auto-approve'

                    def appIP = sh(script: 'terraform output app_ip', returnStdout: true).trim()
                    def ecrAddress = sh(script: 'terraform output ecr_address', returnStdout: true).trim()

                    def content = """\
                    App IP: ${appIP}
                    ECR Address: ${ecrAddress}
                    """

                    writeFile file: '/var/lib/jenkins/env_variables.txt', text: content
                    }                    
                }        
        }
    }
}