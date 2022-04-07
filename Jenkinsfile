pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID="032797834308"
        AWS_DEFAULT_REGION="us-west-1"
        IMAGE_REPO_NAME="aline-banking-tk"
        IMAGE_TAG="latest"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
    stages {
        stage('Build') {
            steps {
                sh "git submodule update --init --recursive"
                sh "mvn clean package -DskipTests"
                sh "docker build . -t user:latest"
            }
        }
        
        stage('Logging into AWS ECR') {
            steps {
                script {
                    sh "aws ecr get-login-password — region ${AWS_DEFAULT_REGION} | docker login --username AWS —-password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }

            }
        }

        stage('Deploy to AWS ECR'){
            steps{
                script {
                    sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"
                    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }
}

