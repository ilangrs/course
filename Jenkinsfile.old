pipeline {
    agent any
    tools {
        maven 'M3'
    }
    stages {
        stage('Git Clone') {
            steps {
                // Get the code from a GitHub repository
                git 'https://github.com/zivkashtan/course.git'
            }
        }
       
        stage('Build Plus SonarQube analysis') {
            steps {
                withSonarQubeEnv(credentialsId: 'sonarqube', installationName: 'Sonarqube') {
                sh '''
                mvn versions:set -DnewVersion=${BUILD_NUMBER}
                mvn clean package org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar -Dsonar.inclusions=/web/**
                '''
                }
            }
        }
       
        stage('Updaload jar to Nexus') {
            steps {
                    docker build .
                    
                    nexusPublisher nexusInstanceId: 'kubeNexus', nexusRepositoryId: 'maven-releases', packages:
                    [
                        [$class: 'MavenPackage', mavenAssetList: [
                            [classifier: '', extension: '', filePath: "${env.WORKSPACE}/core/target/time-tracker-core-${BUILD_NUMBER}.jar"]
                            
                            ], mavenCoordinate: [artifactId: 'time-tracker-parent', groupId: 'clinic.programming.time-tracker', packaging: 'jar', version: "${BUILD_NUMBER}"]],
                    
                    ], tagName: ''
                    
                    nexusPublisher nexusInstanceId: 'kubeNexus', nexusRepositoryId: 'maven-releases', packages: [
                        [$class: 'MavenPackage', mavenAssetList: [
                            [classifier: '', extension: '', filePath: "${env.WORKSPACE}/web/target/time-tracker-web-${BUILD_NUMBER}.war"]
                            ], mavenCoordinate: [artifactId: 'time-tracker-web', groupId: 'clinic.programming.time-tracker', packaging: 'war', version: '${BUILD_NUMBER}']]
                            ], tagName: ''
            }
        }
    }
}
