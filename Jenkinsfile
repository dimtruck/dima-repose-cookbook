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
            when {
                expression {
                   BRANCH_NAME != 'master'
                }
            }
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
                publishHTML([allowMissing: false, alwaysLinkToLastBuild: true, keepAll: true, reportDir: '', reportFiles: 'index.html', reportName: 'ChefSpec Report', reportTitles: ''])
              }
            }
        }
        stage('Integration Tests') {
            when {
                expression {
                   BRANCH_NAME != 'master'
                }
            }
           steps {
                parallel (
                   "integration" : {
                        sh 'KITCHEN_LOCAL_YAML=.kitchen.inspec.yml kitchen list'
                        sh 'KITCHEN_LOCAL_YAML=.kitchen.inspec.yml kitchen test default'
                   },
                   "compliance" : {
                        sh 'kitchen list'
                        sh 'kitchen test default'
                   }
               )
           }        
            post {
              always {
                junit 'serverspec*.xml'
                junit '*inspec.xml'
              }
            }
        }
        stage('Deploy') {
            when {
                expression {
                   BRANCH_NAME == 'master'
                }
            }
            steps {
                echo 'Deploying....'
                withCredentials([file(credentialsId: 'chef-pem', variable: 'CHEFPEM'), usernamePassword(credentialsId: 'dima-token', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME'), file(credentialsId: 'deploy-key', variable: 'DEPLOYKEY')]) {
                    sh "git config --local core.sshCommand 'ssh -i $DEPLOYKEY -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no' "
                    sh 'git config --global user.name dimtruck'
                    sh 'git config --global user.email dimalg@yahoo.com'
                    sh 'git config --local url."git@github.com:".insteadOf https://github.com/'
                    sh 'git remote -v'
                    sh 'stove login --username dimtruck --key $CHEFPEM'
                    sh 'git checkout $BRANCH_NAME && git pull origin $BRANCH_NAME'
                    sh 'bundle exec rake deploy'
                }
            }
        }
    }
/*    post {
      always {
         deleteDir() 
      }
    }*/
}
