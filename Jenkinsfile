pipeline {

    agent none

    stages {
        
        stage('gitcheckout') {
            agent {
                label 'linux-agent'
            }
            
            steps {
                checkout scm
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

                echo "===== ROLLOUT STATUS ====="

                kubectl rollout status deployment/jenkins-demo

                echo "===== POD STATUS ====="

                kubectl get pods -l app=jenkins-demo -o wide

                echo "===== SERVICE ====="

                kubectl get service jenkins-demo-service
            '''
            }
        }
    }
}
