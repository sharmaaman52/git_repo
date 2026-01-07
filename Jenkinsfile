pipeline {
    agent { label 'ec2' }

    parameters {
        choice(name: 'ENV', choices: ['dev', 'qa'], description: 'Select Environment')
    }

    environment {
        APP_NAME = "sample-app"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/sharmaaman52/git_repo.git'
            }
        }

        stage('Build') {
            steps {
                sh '''
                echo "Building $APP_NAME for $ENV"
                ./app.sh
                '''
            }
        }

        stage('Test') {
            steps {
                sh './test.sh'
            }
        }

    }

    post {
        success {
            echo 'Build Successful'
            archiveArtifacts artifacts: 'build/*.txt'
        }

        failure {
            echo 'Build Failed'
        }

        always {
            cleanWs()
        }
    }
}
