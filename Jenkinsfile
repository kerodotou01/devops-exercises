pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = credentials('dockerhub-credentials') 
        DOCKER_IMAGE_NAME = 'kerodo01/hello-world-app' 
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/kerodotou01/devops-exercises.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE_NAME} ."
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker Hub
                    sh "echo ${DOCKER_CREDENTIALS_PSW} | docker login -u ${DOCKER_CREDENTIALS_USR} --password-stdin"
                    sh "docker push ${DOCKER_IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker images to save space
            sh 'docker rmi ${DOCKER_IMAGE_NAME} || true'
        }
    }
}
