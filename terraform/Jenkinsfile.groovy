pipeline {
    agent any


    stages {
        stage('Pull') {
            steps {
                git branch: 'main', url:'https://github.com/wolender/Final_Project.git'
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
                withCredentials([aws(credentials: 'Amazon', region: 'eu-central-1')]) {
                dir('terraform') {
                    sh 'terraform plan'
                }

            }
        }        
    }
}