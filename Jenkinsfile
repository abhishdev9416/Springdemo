pipeline{
    agent{label 'AGENT'}
    triggers{pollSCM('* * * * *')}
    stages{
        stage('VCS'){
            steps{
                git url: 'https://github.com/abhishdev9416/Springdemo.git',
                branch: 'develop'
            }
        }
        stage('SonarQube analysis'){
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
    }
    post{
        success{
            mail subject: "Jenkins Job of ${JOB_NAME} of build no ${BUILD_ID} is successfull",
                 body: "For more info click on the URL - ${BUILD_URL}",
                 from: 'Jenkins@abhish.com',
                 to: 'abhish9416@outlook.com'
        }
        failure{
            mail subject: "Jenkins Job of ${JOB_NAME} of build no ${BUILD_ID} is fialed",
                 body: "For more info click on the URL - ${BUILD_URL}",
                 from: 'Jenkins@abhish.com',
                 to: 'abhish9416@outlook.com'
            }
    }
}