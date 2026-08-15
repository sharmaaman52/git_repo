pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'qa', 'prod'],
            description: 'Select deployment environment'
        )

        string(
            name: 'VERSION',
            defaultValue: '1.0',
            description: 'Enter application version'
        )
    }

    stages {

        stage('Build') {
            steps {
                echo "===== BUILD ====="
                echo "Environment: ${params.ENVIRONMENT}"
                echo "Version: ${params.VERSION}"

                sh 'hostname'
                sh 'whoami'
            }
        }

        stage('Test') {
            steps {
                echo "===== TEST ====="
                echo "Testing version ${params.VERSION}"
                echo "Environment: ${params.ENVIRONMENT}"
            }
        }

        stage('Package') {
            steps {
                echo "===== PACKAGE ====="

                sh 'mkdir -p build'

                sh 'echo "Application: my-application" > build/app.txt'
                sh 'echo "Environment: $ENVIRONMENT" >> build/app.txt'
                sh 'echo "Version: $VERSION" >> build/app.txt'

                sh 'cat build/app.txt'
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }

        success {
            echo 'Pipeline completed successfully.'
        }

        failure {
            echo 'Pipeline failed.'
        }
    }
}
