pipeline {
    agent any
    environment {
      IMAGE = "petclinic"
   }
    
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
		          sh "mvn -B -DskipTests clean package"
            }
	         post {
		         success {
		            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
		         }
	         }
        }

        stage('Image') {
            steps {
               echo 'Creating Image'
               sh "docker build -t $IMAGE:$BUILD_NUMBER ."
            }
        }
    }
}
