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
                dir('terraform/backend') {
                    sh 'terraform fmt'
                }
               
            }
        }

        stage('Init') {
            steps{
                dir('terraform/backend') {
                    sh 'terraform init'
                }
               
            }
        }

        stage('Validate') {
            steps{
                dir('terraform/backend') {
                    sh 'terraform validate'
                }
               
            }
        }

        stage('Plan') {
            steps{
                dir('terraform/backend') {
                        sh 'terraform plan'
                    }                    
                }        
        }

        stage('Apply') {
            steps{
                dir('terraform/backend') {
                        sh 'terraform apply -auto-approve'
                    }                    
                }        
        }
    }
}