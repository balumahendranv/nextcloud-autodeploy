pipeline {
    agent any
    parameters {
        string(name: 'DEPLOYMENT_MODE', defaultValue: 'docker', choices: ['docker', 'k8s'], description: 'Choose deployment type')
        string(name: 'SUBDOMAIN', defaultValue: 'cloud1', description: 'Subdomain for Nextcloud (e.g., cloud1)')
    }
    environment {
        DOMAIN = "${params.SUBDOMAIN}.rootedinfra.site"
    }
    stages {
        stage('Clone Repo') {
            steps {
                git url: 'https://your.git.repo/nextcloud-autodeploy.git'
            }
        }
        stage('Deploy') {
            steps {
                script {
                    if (params.DEPLOYMENT_MODE == 'docker') {
                        sh "./deploy.sh docker $DOMAIN"
                    } else {
                        sh "./deploy.sh k8s $DOMAIN"
                    }
                }
            }
        }
    }
}
