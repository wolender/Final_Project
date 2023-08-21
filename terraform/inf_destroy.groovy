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


        stage('Validate') {
            steps{
                dir('terraform') {
                    sh 'terraform validate'
                }
               
            }
        }

        stage('Destroy') {
            steps{
                dir('terraform') {
                        sh 'terraform destroy -auto-approve'
                    }                    
                }        
        }

    }
}