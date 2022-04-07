pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh "git submodule update --init --recursive"
                sh "mvn clean package -DskipTests"
                sh "docker build . -t user:latest"
            }
        }
        
        stage('Deploy to AWS ECR'){
            steps{
                    sh '''docker login --username AWS 032797834308.dkr.ecr.us-east-1.amazonaws.com --password $(aws ecr get-login-password --region us-east-1)'''
                    sh "docker tag user:latest public.ecr.aws/c0j0y9o1/aline-banking-tk:latest"
                    sh "docker push public.ecr.aws/c0j0y9o1/aline-banking-tk:latest"
                    sh "docker system prune -f --volumes"
            }
        }
    }
}
