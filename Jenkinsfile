pipeline{
    agent any
    stages{
        stage("TF Init"){
            steps{
                echo "Executing Terraform Init"
                sh "ls -lrth"
              //  sh "terraform init"
               //sh  "terraform plan -auto-approve"
           // sh  "terraform apply -auto-approve  "
            }
        }
        stage("TF Validate"){
            steps{
                echo "Validating Terraform Code"
            }
        }
        stage("TF Plan"){
            steps{
                echo "Executing Terraform Plan"
            }
        }
        stage("TF Apply"){
            steps{
             //   sh  "terraform apply -auto-approve"
                sh  "terraform destroyy -auto-approve"
            }
        }
        stage("Invoke Lambda"){
            steps{
                echo "Invoking your AWS Lambda"
            }
        }
    }
}
