pipeline {
    agent any

    environment {
        COMPOSE_PROJECT_NAME = "nextcloud"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/balumahendranv/nextcloud-autodeploy.git'
            }
        }

        stage('Setup Env File') {
            steps {
                writeFile file: 'docker/.env', text: '''
NEXTCLOUD_ADMIN_USER=admin
NEXTCLOUD_ADMIN_PASSWORD=admin123
MYSQL_ROOT_PASSWORD=rootpass
MYSQL_PASSWORD=nextcloudpass
MYSQL_DATABASE=nextcloud
MYSQL_USER=nextcloud
NEXTCLOUD_DOMAIN=nextcloud.rootedinfra.site
'''
            }
        }

        stage('Pull Latest Images') {
            steps {
                dir('docker') {
                    sh 'docker compose pull'
                }
            }
        }

        stage('Shut Down Previous Stack') {
            steps {
                dir('docker') {
                    sh 'docker compose down'
                }
            }
        }

        stage('Start New Stack') {
            steps {
                dir('docker') {
                    sh 'docker compose up -d'
                }
            }
        }
    }

    post {
        success {
            echo "✅ Nextcloud is deployed at https://nextcloud.rootedinfra.site"
        }
        failure {
            echo "❌ Deployment failed. Check Jenkins logs."
        }
    }
}
