pipeline {
    agent {

        label 'ec2-fleet'

        }
    tools {
        maven 'mvn'
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
                        terraform plan
                        """
                        }
                    }
                                       
                }        
        }

        stage('Apply') {
            steps{
                dir('terraform') {
                        withCredentials([usernamePassword(credentialsId: 'db_creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        
                        sh """
                        export TF_VAR_MySQL_password=${PASSWORD}
                        export TF_VAR_MySQL_login=${USERNAME}
                        terraform apply -auto-approve
                        """
                        sh 'echo "env.APP_IP=$(terraform output app_ip)" > ./env_variables.groovy'
                        sh 'echo "env.REPO_URL=$(terraform output ecr_address)" >> ./env_variables.groovy'
                        sh 'echo "env.MYSQL_URL=$(terraform output DB_url)" >> ./env_variables.groovy'
                        sh 'echo "env.APP_LB_URL=$(terraform output app_lb_ip)" >> ./env_variables.groovy'
            
                        archiveArtifacts artifacts: "env_variables.groovy", fingerprint: true
                        }
                    
                    }                    
                }        
        }
    }
}