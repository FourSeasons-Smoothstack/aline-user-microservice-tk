pipeline {
    agent any
    environment {
        AWS_ID = credentials('AWS-ID')
        ART_USER = credentials('ART_USER')
        ART_PASS = credentials('ART_PASS')
        ART_URL = credentials('ART_URL')
        ART_MAVEN_REPO = credentials('ART_MAVEN_REPO')
    }
    stages{

        // stage('Scan Sonarqube'){
        //     steps{
        //         withSonarQubeEnv(installationName: 'SQ-dw'){
        //             sh "git submodule update --init --recursive"
        //             sh "mvn clean verify sonar:sonar"
        //         }
        //     }
        // }

        // stage('Quality Gate'){
        //     steps{
        //         timeout(time: 2, unit: 'MINUTES'){
        //             waitForQualityGate abortPipeline: true
        //         }
        //     }
        // }
        stage('Build') {
            steps {
                sh "git submodule update --init --recursive"
                sh "mvn clean install -DskipTests"
                sh "docker build -t aline-user-tk:latest ."
            }
        }
        
        stage('Logging into AWS ECR') {
            steps {
                withAWS(credentials: 'AWS-TK', region: 'us-west-1') {
                    sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${AWS_ID}.dkr.ecr.us-east-1.amazonaws.com"
                }
            }
        }

        stage('Deploy to AWS ECR'){
            steps{
                script {
                    sh "docker tag aline-user-tk:latest ${AWS_ID}.dkr.ecr.us-east-1.amazonaws.com/aline-user-tk:latest"
                    sh "docker push ${AWS_ID}.dkr.ecr.us-east-1.amazonaws.com/aline-user-tk:latest"
                    sh "docker system prune -af"
                    sh "docker volume prune -f"
                }
            }
        }

        stage('Deploy to Artifactory') {
            steps {
                script {
                    sh "curl -X PUT -u ${ART_USER}:${ART_PASS} -T user-microservice/target/*.jar 'http://ec2-50-18-84-74.us-west-1.compute.amazonaws.com:8081/artifactory/${ART_MAVEN_REPO}/aline-user.jar'"
                }
            }
        }
    }
}

