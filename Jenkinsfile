pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp"
        CONTAINER_NAME = "myapp_container"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/sharmaaman52/git_repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                  echo "Building Docker image..."
                  docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                  echo "Stopping old container (if exists)..."
                  docker stop $CONTAINER_NAME || true
                  docker rm $CONTAINER_NAME || true

                  echo "Running new container..."
                  docker run -d --name $CONTAINER_NAME -p 3000:3000 $IMAGE_NAME
                '''
            }
        }
    }

    post {
        success {
            echo 'Docker container is up and running!'
        }
        failure {
            echo 'Build failed. Check logs.'
        }
    }
}
