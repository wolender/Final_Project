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
                        sh 'terraform plan'
                    }                    
                }        
        }

        stage('Apply') {
            steps{
                dir('terraform') {

                    sh 'terraform apply -auto-approve'

                    sh 'echo "env.APP_IP=$(terraform output app_ip)" > /var/lib/jenkins/env_variables.groovy'
                    sh 'echo "env.REPO_URL=$(terraform output ecr_address)" >> /var/lib/jenkins/env_variables.groovy'
                    sh 'echo "env.MYSQL_URL=$(terraform output DB_url)" >> /var/lib/jenkins/env_variables.groovy'
                    sh 'echo "env.APP_LB_URL=$(terraform output app_lb_ip)" >> /var/lib/jenkins/env_variables.groovy'
                    // sh 'echo "env.MYSQL_PASS=$(terraform output db_password)" >> /var/lib/jenkins/env_variables.groovy'
                    sh 'echo "env.MYSQL_USER=$(terraform output db_user)" >> /var/lib/jenkins/env_variables.groovy'
                    }                    
                }        
        }
    }
}