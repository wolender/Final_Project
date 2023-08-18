pipeline {
    agent any


    stages {
        stage('Pull') {
            steps {
                git branch: 'main', url:'https://github.com/wolender/Final_Project.git'
            }
        }

        stage('login') {
            steps{
                withCredentials([usernamePassword(credentialsId: 'AWS', usernameVariable: 'ID', passwordVariable: 'KEY')]) {
                    
                    sh 'eport AWS_ACCESS_KEY_ID=$ID'
                    sh 'export AWS_SECRET_ACCESS_KEY=$KEY'
                    sh 'export AWS_DEFAULT_REGION=eu-central-1'

                }
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
                    sh 'terraform init'
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
    }
}