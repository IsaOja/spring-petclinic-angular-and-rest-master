pipeline {
    agent any
    stages {
        stage('Build Rest-API') {
                    steps {
                        sh 'cd spring-petclinic-rest-master/spring-petclinic-rest-master && nohup mvn spring-boot:run &'
                        sh 'sleep 11'
                    }
                }

        stage('Build Angular-Front End') {
            steps {
                sh 'cd spring-petclinic-angular/static-content && curl https://jcenter.bintray.com/com/athaydes/rawhttp/rawhttp-cli/1.0/rawhttp-cli-1.0-all.jar -o rawhttp.jar && nohup java -jar ./rawhttp.jar serve . -p 4200 &'
                sh 'sleep 11'

            }
        }
         
        stage('Test') {
            steps {
                sh "mvn test"
            }
            post {
                always {
                    junit '**/TEST*.xml'
                }
            }

        } 
      
       
   
 stage('Robot') {
            steps {
                catchError {
                sh 'robot --variable BROWSER:headlesschrome -d spring-petclinic-angular/RenuRobot/SpecialtyHOME/Tests/Results spring-petclinic-angular/RenuRobot/SpecialtyHOME/Tests'
                            }
                  }     
            post {
                always {
                    script {
                        step(
                            [
                                $class                  :   'RobotPublisher',
                                outputPath              :   'spring-petclinic-angular/RenuRobot/SpecialtyHome/Tests/Results',
                                outputFileName          :   '**/output.xml',
                                reportFileName          :   '**/report.html',
                                logFileName             :   '**/log.html',
                                disableArchiveOutput    :   false,
                                passThreshold           :   50,
                                unstableThreshold       :   40,
                                otherFiles              :   "**/*.png,**/*.jpg",
                            ]
                        )
                    }
                }
            }
        }
      
        stage('Postman') {
            steps {
                sh 'newman run PostmanFiles/PCollection.postman_collection.json -e PostmanFiles/PEnvironment.postman_environment.json -- reporters junit'
            }
           
                post {
                always {
                    junit '**/TEST*.xml'
                }
              }

        } 
    
  }
}
