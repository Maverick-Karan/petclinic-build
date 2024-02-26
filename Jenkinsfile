pipeline {
    agent any
    environment {
      IMAGE = "petclinic"
      SONAR_SCANNER_HOME = tool 'sonarscanner'
      SONAR_TOKEN = credentials('SONAR_TOKEN')
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

        stage('Unit Test') {
            steps {
                echo 'Testing...'
                sh "mvn test -Dcheckstyle.skip"
            }
	         post {
		         always {
		            junit 'target/surefire-reports/*.xml'
		         }
	         }
        }

        stage('INTEGRATION TEST'){
            steps {
                sh 'mvn verify -DskipUnitTests'
            }
        }
		
        stage ('CODE ANALYSIS WITH CHECKSTYLE'){
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
            post {
                success {
                    echo 'Generated Analysis Result'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv(installationName: 'sonarscanner') {
                    sh '''
                        ${SONAR_SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectKey=maverick-karan_petclinic \
                        -Dsonar.sources=src/ \
                        -Dsonar.tests=src/test \
                        -Dsonar.host.url=https://sonarcloud.io \
                        -Dsonar.login=${SONAR_TOKEN} \
                        -Dsonar.junit.reportsPath=target/surefire-reports/ \
                        -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                        -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml
                    '''
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
