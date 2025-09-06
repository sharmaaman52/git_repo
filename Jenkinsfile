pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sharmaaman52/git_repo.git'
            }
        }

        stage('Build') {
            steps {
                sh '''
                  echo "Building project..."
                  mkdir -p target
                  echo "Hello Jenkins Pipeline" > target/output.txt
                '''
            }
        }

        stage('Test') {
            steps {
                sh 'echo "Running tests..."'
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'target/*.txt', fingerprint: true
            }
        }
    }
}
