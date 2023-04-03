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
                sh  "terraform validate "
            }
        }
        stage("TF Plan"){
            steps{
                echo "Executing Terraform Plan"
                sh  "terraform plan "
            }
        }
        
           stage("TF create S3 using AWS cli"){
            steps{
                sh "aws --version" // checking aws cli version
            //   sh "aws s3 mb s3://abhijeetnikam1995"  //getting access denied error
            }
        }

        
        
        
        
        stage("TF Apply"){
            steps{
                sh  "terraform apply -auto-approve"
              //  sh  "terraform destroy -auto-approve"
            }
        }
        stage("Invoke Lambda"){
            steps{
                echo "Invoking your AWS Lambda"
            }
        }
    }
}
