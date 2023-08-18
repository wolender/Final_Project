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
               sh 'terraform fmt'
            }
        }
        stage('Validate') {
            steps{
               sh 'terraform validate'
            }
        }
        stage('Init') {
            steps{
               sh 'terraform init'
            }
        }
        stage('Plan') {
            steps{
               sh 'terraform plan'
            }
        }        
    }
}