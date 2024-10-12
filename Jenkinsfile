pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = credentials('dockerhub-credentials') 
        DOCKER_IMAGE_NAME = 'kerodo01/hello-world-app' 
        dockerImage = ''
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
                    dockerImage = docker build -t ${DOCKER_IMAGE_NAME} .
                    echo 'Docker image built successfully!'
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    echo 'Pushing Docker image to Docker Hub...'

                    // Use the withCredentials block to access Docker credentials securely
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        script {
                            // Login to Docker Hub
                            sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                        }
                    }

                    // Log in to Docker Hub
                    // docker.withRegistry('', 'dockerhub-credentials') {
                    //     dockerImage.push()
                    // }
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
