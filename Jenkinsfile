pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = credentials('dockerhub-credentials') 
        DOCKER_IMAGE_NAME = 'kerodo01/hello-world-app' 
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning the repository...'
                git branch: 'hello-world-app',
                    url: 'git@github.com:kerodotou01/devops-exercises.git',
                    credentialsId: 'github-ssh-credentials'
                echo 'Successfully cloned the repository!'

            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building the Docker image...'
                    sh "docker build -t ${DOCKER_IMAGE_NAME} ."
                    echo 'Docker image built successfully!'
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    echo 'Pushing Docker image to Docker Hub...'
                    // Log in to Docker Hub
                    docker.withRegistry('', 'dockerhub-credentials')
                    // sh "echo ${DOCKER_CREDENTIALS_PSW} | docker login -u ${DOCKER_CREDENTIALS_USR} --password-stdin"
                    sh "docker push ${DOCKER_IMAGE_NAME}"
                    echo 'Docker image pushed successfully!'

                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up Docker images to save space...'
            // Clean up Docker images to save space
            sh 'docker rmi ${DOCKER_IMAGE_NAME} || true'
            echo 'Cleanup complete.'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs for more details.'
        }        
    }
}
