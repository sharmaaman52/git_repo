pipeline {

    agent none

    stages {

        stage('Git Checkout') {

            agent {
                label 'linux-agent'
            }

            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {

            agent {
                label 'linux-agent'
            }

            steps {
                sh '''
                    echo "===== BUILDING DOCKER IMAGE ====="

                    docker build \
                    -t aman9372/jenkins-demo:${BUILD_NUMBER} .
                '''
            }
        }

        stage('Login to Docker Hub') {

            agent {
                label 'linux-agent'
            }

            steps {

                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-cred',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_TOKEN'
                    )
                ]) {

                    sh '''
                        echo "$DOCKER_TOKEN" | docker login \
                        -u "$DOCKER_USER" \
                        --password-stdin
                    '''
                }
            }
        }

        stage('Push Docker Image') {

            agent {
                label 'linux-agent'
            }

            steps {

                sh '''
                    echo "===== PUSHING IMAGE ====="

                    docker push aman9372/jenkins-demo:${BUILD_NUMBER}
                '''
            }
        }

        stage('Deploy to Kubernetes') {

            agent {
                label 'linux-agent'
            }

            steps {

                withKubeConfig(
                    credentialsId: 'kubernetes-cred'
                ) {

                    sh '''
                        echo "===== DEPLOYING TO KUBERNETES ====="

                        kubectl apply -f deployment.yaml
                        kubectl apply -f service.yaml

                        echo "===== UPDATING IMAGE ====="

                        kubectl set image deployment/jenkins-demo \
                        jenkins-demo=aman9372/jenkins-demo:${BUILD_NUMBER}

                        echo "===== ROLLOUT STATUS ====="

                        kubectl rollout status deployment/jenkins-demo

                        echo "===== POD STATUS ====="

                        kubectl get pods -l app=jenkins-demo -o wide

                        echo "===== DEPLOYED IMAGE ====="

                        kubectl get deployment jenkins-demo \
                        -o jsonpath='{.spec.template.spec.containers[0].image}'

                        echo
                    '''
                }
            }
        }
    }

    post {

        success {
            echo "===== CI/CD PIPELINE SUCCESSFUL ====="
        }

        failure {
            echo "===== CI/CD PIPELINE FAILED ====="
        }
    }
}
