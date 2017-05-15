pipeline {
    agent {
      label 'swarm'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'bundle install --path vendor'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
