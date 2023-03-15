pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'europe-west6-docker.pkg.dev'
        PROJECT_ID = 'cloud-run-demo-project-373714'
        REPOSITORY_NAME = 'demo-cloud-run-registry/test'
        IMAGE_TAG = 'latest'
        GOOGLE_APPLICATION_CREDENTIALS = '/path/to/your-service-account-key.json'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Go Test') {
            steps {
                sh 'go test -v ./...'
            }
        }

        stage('Go Build') {
            steps {
                sh 'go build -o myapp'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'gcp-service-account', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                        docker.withRegistry("https://${DOCKER_REGISTRY}", 'gcp-artifact-registry-credentials') {
                            def appImage = docker.build("${DOCKER_REGISTRY}/${PROJECT_ID}/${REPOSITORY_NAME}:${IMAGE_TAG}")
                        }
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'gcp-service-account', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                        docker.withRegistry("https://${DOCKER_REGISTRY}", 'gcp-artifact-registry-credentials') {
                            def appImage = docker.image("${DOCKER_REGISTRY}/${PROJECT_ID}/${REPOSITORY_NAME}:${IMAGE_TAG}")
                            appImage.push()
                        }
                    }
                }
            }
        }
    }
}
