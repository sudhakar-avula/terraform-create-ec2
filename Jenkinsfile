pipeline {

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
        stage('checkout') {
            steps {
                script {
                    echo "Git clone Started!"
                    dir("terraform") {
                        git branch: 'main', url: 'https://github.com/sudhakar-avula/terraform-create-ec2.git'
                    }
                    echo "Git clone successful!"
                }
            }
        }

        stage('Plan') {
            steps {
                script {
                    echo "terraform init Started!"
                    dir("terraform") {
                         sh 'terraform init'
                         sh "terraform plan -out tfplan"
                    }
                    echo "terraform init successful!"
                }
            }
        }

        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    def plan = readFile 'terraform/tfplan'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            steps {
               echo "Apply begin"
                    dir("terraform") {
                        sh "terraform apply -input=false tfplan"
                    }
               echo "Apply end"
            }
        } 
     }
        post {
        always {
            //Cleanup the Terraform plan file
            sh "rm -f tfplan"
        }
        success {
            echo "Terraform deployment successful!"
        }
        failure {
            echo "Terraform deployment failed!"
        }
    }
  }
