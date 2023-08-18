pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven"
    }
    environment {
        SETTINGS = '/var/lib/jenkins/settings.xml'
    }

    stages {
        stage('Pull') {
            steps {
                // Get some code from a GitHub repository
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
               sh 'terraform vaidate'
            }
        }
        stage('Plan') {
            steps{
               sh 'terraform plan'
            }
        }        
    }
}