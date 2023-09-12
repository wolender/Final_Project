pipeline {
    agent {

        label 'ec2-fleet'

        }


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
                    withCredentials([usernamePassword(credentialsId: 'db_creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh """
                        export TF_VAR_MySQL_password=${PASSWORD}
                        export TF_VAR_MySQL_login=${USERNAME}
                        sh 'terraform plan'
                        """
                        }
                    }                    
                }        
        }

    }
}