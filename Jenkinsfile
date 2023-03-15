pipeline{
    agent{label 'AGENT'}
    triggers{pollSCM('* * * * *')}
    stages{
        stage('Version Control System'){
            steps{
                git url: 'https://github.com/abhishdev9416/Springdemo.git',
                branch: 'develop'
            }
        }
        stage('SonarQube analysis') {
            steps{
                withSonarQubeEnv('Sonar_Cloud'){
                    sh ' mvn clean verify sonar:sonar -D sonar.organization=springpetclinic16 -Dsonar.projectKey=springpetclinic16'
                } // You can override the credential to be used
            } 
        }
        stage('Build'){
            steps{
                sh 'cd ./.devcontainer && docker image build -t abhish9416/spc:latest .' //building the docker image
            }
        }
        stage('Docker Scan and Push'){
            steps{
                sh 'docker scan abhish9416/spc:latest' //scanning the  vulnerabilities
                sh 'echo build scan done'
                sh 'docker image push abhish9416/spc:latest' // pushing the docker image to docker hub
                sh 'echo build push done'
            }
        }
    post{
        success{
            mail subject: "Jenkins jobs of ${JOB_NAME} of with ${BUILD_ID} is successfull",
                 body: "Please use this url ${BUILD_URL} for more information",
                 to: 'abhishek16tiwary@gmail.com',
                 from: 'jenkins@abhish.com'
             }
        failure{
            mail subject: "Jenkins jobs of ${JOB_NAME} of with ${BUILD_ID} is Failed",
                 body: "Please use this url {$BUILD_URL} for more information",
                 to: '${GIT_AUTHOR_EMAIL}',
                 from: 'jenkins@abhish.com'
            }
        } 
    }
}