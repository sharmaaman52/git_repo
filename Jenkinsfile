pipeline {
    agent any

    stages {

        stage('Build') {
            steps {
                echo '===== BUILD ====='
                sh 'hostname'
                sh 'whoami'
                sh 'pwd'
            }
        }

        stage('Test') {
            steps {
                echo '===== TEST ====='
                sh 'echo "Testing application..."'
                sh 'echo "Tests passed"'
            }
        }

        stage('Package') {
            steps {
                echo '===== PACKAGE ====='
                sh 'mkdir -p build'
                sh 'echo "Jenkins Pipeline Artifact" > build/app.txt'
                sh 'cat build/app.txt'
            }
        }

    }
}
