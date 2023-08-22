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

                    sh 'echo "" > /var/lib/jenkins/env.variables'
                    sh 'terraform output app_ip >> /var/lib/jenkins/env.variables'
                    sh 'terraform output ecr_address >> /var/lib/jenkins/env.variables'
                    }                    
                }        
        }
    }
}