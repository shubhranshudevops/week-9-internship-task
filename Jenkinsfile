pipeline {

    agent any
    
    tools {
            nodejs 'node'
    }
    
    environment {
        APP_NAME = "internship-task-week-9"
        DOCKER_IMAGE = "shubh01devops/week-9-internship-task"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code from GitHub...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Installing dependencies and building application...'
                sh 'npm install'
                sh 'npm run build'
            }
        }

        stage('Test') {
            steps {
                echo 'Running automated tests...'
                sh 'npm test'
            }
        }

        stage('Package') {
            steps {
                echo 'Creating application package...'
                sh 'tar -czf ${APP_NAME}-${BUILD_NUMBER}.tar.gz server.js package.json Dockerfile'
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} .'
            }
        }

        stage('Docker Push') {
            steps {
                echo 'Pushing Docker image to Docker Hub...'

                withCredentials([usernamePassword(credentialsId: 'docker_hub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) 

                sh 'docker tag ${DOCKER_IMAGE}:${IMAGE_TAG} ${DOCKER_IMAGE}:latest'
                sh 'docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}'
                sh 'docker push ${DOCKER_IMAGE}:${IMAGE_TAG}'
                sh 'docker push ${DOCKER_IMAGE}:latest'
                sh 'docker logout'
                
            }
        }
    }

    post {
        success {
            echo 'CI/CD Pipeline completed successfully.'
        }

        failure {
            echo 'Pipeline failed. Check the Jenkins console output.'
        }

        always {
            echo 'Pipeline execution completed.'
        }
    }
}
