pipeline {
    agent any
    environment {
      IMAGE = "petclinic"
   }
    
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
		          sh '''
                  ./pipeline/build/mvn.sh mvn -DskipTests clean package
                  ./pipeline/build/build.sh
                '''
            }
	         post {
		         success {
		            archiveArtifacts artifacts: 'petclinic-app/target/*.jar', fingerprint: true
		         }
	         }
        }
    }
}