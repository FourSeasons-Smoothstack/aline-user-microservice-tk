pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh "git submodule update --init --recursive"
                sh "mvn clean package -DskipTests"
                sh "docker build -t aline-user-tk ."
            }
        }
        
        stage('Logging into AWS ECR') {
            steps {
                withAWS(credentials: 'AWS-TK', region: 'us-west-1') {
                    sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 032797834308.dkr.ecr.us-east-1.amazonaws.com"
                }
            }
        }

        stage('Deploy to AWS ECR'){
            steps{
                script {
                    sh "docker tag aline-user-tk:latest 032797834308.dkr.ecr.us-east-1.amazonaws.com/aline-user-tk:latest"
                    sh "docker push 032797834308.dkr.ecr.us-east-1.amazonaws.com/aline-user-tk:latest"
                }
            }
        }
    }
}

