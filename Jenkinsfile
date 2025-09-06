pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "myapp:${env.BUILD_NUMBER}"
    }
    stages {
        stage('Checkout') {
            steps {
                echo 'Fetching code from GitHub'
                git branch: 'master', url: 'https://github.com/Kasimalbatros/aaaa.git'
            }
        }
        stage('Build') {
            steps {
                echo 'Building Docker image'
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }
        stage('Unit Test') {
            steps {
                echo 'Running Unit Tests'
                sh "docker run --rm ${DOCKER_IMAGE} python -m pytest tests/unit/ -v"
            }
        }
        stage('Integration Test') {
            steps {
                echo 'Running Integration Tests'
                sh "docker run --rm ${DOCKER_IMAGE} python -m pytest tests/integration/ -v"
            }
        }
        stage('API Test') {
            steps {
                echo 'Running API Tests'
                sh "docker run --rm ${DOCKER_IMAGE} python -m pytest tests/api/ -v"
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying Docker container'
                sh "docker run -d -p 8080:8080 ${DOCKER_IMAGE}"
            }
        }
    }
    post {
        always {
            echo 'Pipeline finished, cleanup if necessary'
            sh 'docker system prune -f'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
