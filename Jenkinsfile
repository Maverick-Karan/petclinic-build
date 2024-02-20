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
                  chmod +x ./pipeline/build/mvn.sh ./pipeline/build/build.sh
                  ./pipeline/build/mvn.sh mvn -DskipTests clean package
                  cp /home/ec2-user/build/petclinic-app/target/*.jar /home/ec2-user/build/pipeline/build/
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