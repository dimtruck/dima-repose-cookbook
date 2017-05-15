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
                sh 'bundle exec rake'
                checkstyle canComputeNew: false, canRunOnFailed: true, defaultEncoding: '', healthy: '', pattern: 'int-lint-results.xml', unHealthy: ''

            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
    post {
      always {
        deleteDir() /* clean up our workspace */
      }
    }
}
