pipeline {
    agent any
    environment {
      IMAGE = "petclinic"
      SONAR_SCANNER_HOME = tool 'sonarscanner'
      SONAR_TOKEN = credentials('SONAR_TOKEN')
      DOCKER_USER = "maverick8266"
      PASS = credentials('dockerhub-pass')
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
                        -Dsonar.organization=maverick-karan \
                        -Dsonar.sources=src/main \
                        -Dsonar.exclusions=**/*.java \
                        -Dsonar.host.url=https://sonarcloud.io \
                        -Dsonar.token=${SONAR_TOKEN} \
                        -Dsonar.junit.reportsPath=target/surefire-reports/ \
                        -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                        -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml
                    '''
                }
            }
        }

        stage('Build Image') {
            steps {
               echo 'Creating Image... '
               sh "docker build -t $IMAGE:$BUILD_NUMBER ."
            }
        }

        stage('Push Image') {
            steps {
               echo 'Pushing to Dockerhub...'
               sh '''
                  echo "*** Logging In ***"
                  docker login -u $DOCKER_USER -p $PASS 
                  echo "*** Tagging image ***"
                  docker tag $IMAGE:$BUILD_NUMBER $DOCKER_USER/$IMAGE:$BUILD_NUMBER
                  echo "*** Pushing image ***" 
                  docker push $DOCKER_USER/$IMAGE:$BUILD_NUMBER
               '''
            }
        }
    }
}
