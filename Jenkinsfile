pipeline {
    agent any

    stages {
        stage('Build') {
            docker.image('ruby:2.3.1').inside {
              stage("Install Bundler") {
                sh "gem install bundler --no-rdoc --no-ri"
              }
            }
            steps {
                echo 'Building..'
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
