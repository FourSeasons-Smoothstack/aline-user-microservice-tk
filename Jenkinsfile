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
                    sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/c0j0y9o1'
                    sh "docker tag user:latest public.ecr.aws/c0j0y9o1/aline-banking-tk:latest"
                    sh "docker push public.ecr.aws/c0j0y9o1/aline-banking-tk:latest"
                    sh "docker system prune -f --volumes"
            }
        }
    }
}
