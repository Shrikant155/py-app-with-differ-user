pipeline {
   agent any 
    stages {
       stage("fetch-repo") {
         steps {
          git branch: 'main',
          credentialsId: 'github-cred-id',
          url: 'https://github.com/Shrikant155/py-app-with-differ-user.git' 
         }

       }
       stage("build-docker-image") {
         steps {
          sh 'docker build  --no-cache -t py-app-user2:${BUILD_NUMBER} .'

         }

       }
        stage("deploy") {
          steps {
           sh 'docker run -d -p 5000:5000 py-app-user2:${BUILD_NUMBER}'
          }
        }

    }
   post {
     always {
      sh 'docker system prune -f'
      }
      success {
      echo 'all stages are runs ok'
      } 
      failure {
        echo 'somthng is failed"
       }
   }

}
