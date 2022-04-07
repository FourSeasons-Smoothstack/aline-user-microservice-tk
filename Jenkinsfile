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
                script{
                        docker.withRegistry('public.ecr.aws/c0j0y9o1/aline-banking-tk', 'ecr:us-west-1:AWS-TK') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                        
                    }
            }
        }
    }
}
