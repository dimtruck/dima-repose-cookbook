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
        stage('Lint Test') {
            steps {
                echo 'Testing..'
                sh 'bundle exec rake rubocop'
                sh 'bundle exec rake foodcritic'

            }
            post {
              always {
                checkstyle canComputeNew: false, canRunOnFailed: true, defaultEncoding: '', healthy: '', pattern: 'int-lint-results.xml', unHealthy: ''
                warnings canComputeNew: false, canResolveRelativePaths: false, canRunOnFailed: true, consoleParsers: [[parserName: 'Foodcritic']], defaultEncoding: '', excludePattern: '', healthy: '', includePattern: '', messagesPattern: '', unHealthy: ''

              }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
    //post {
     // always {
        // deleteDir() /* clean up our workspace */
    //  }
   // }
}
