pipeline {
    agent {
      label 'swarm'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'bundle install'
            }
        }
        stage('Local Tests') {
            steps {
                echo 'Testing..'
                sh 'bundle exec rake rubocop'
                sh 'bundle exec rake foodcritic'
                sh 'bundle exec rake unit'

            }
            post {
              always {
                checkstyle canComputeNew: false, canRunOnFailed: true, defaultEncoding: '', healthy: '', pattern: 'int-lint-results.xml', unHealthy: ''
                warnings canComputeNew: false, canResolveRelativePaths: false, canRunOnFailed: true, consoleParsers: [[parserName: 'Foodcritic']], defaultEncoding: '', excludePattern: '', healthy: '', includePattern: '', messagesPattern: '', unHealthy: ''
                junit 'junit.xml'
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
