# AWS-Cloud-Cost-Optimization-Insights-Platform-

"Real-time cost tracking across AWS services"

## Technical Architecture

![image_alt](https://github.com/Tatenda-Prince/AWS-Cloud-Cost-Optimization-Insights-Platform-/blob/4272b81217e94f98d8c3e48fc49052395836e6bf/img/Screenshot%202025-02-22%20132701.png)

## Project Overview

The AWS Cost Optimization & Insights is a real-time cost tracking system designed to help businesses monitor and optimize AWS spending efficiently. It provides interactive visualizations and automated alerts to prevent unexpected cost spikes.

## Project Objective

1.Automate AWS cost tracking with real-time data.

2.Provide clear insights into daily and monthly AWS spending.

3.Send alerts for unusual cost spikes using CloudWatch Alarms & SNS.

4.Help businesses optimize AWS resources to reduce unnecessary expenses.

## Features

1.Real-time AWS Cost Tracking – View daily and monthly AWS usage.

2.Customizable Alerts – Get notified when spending exceeds a set threshold.

3.User-friendly Dashboard – Simple and intuitive web interface. 

4.Automated Infrastructure – Fully deployed using Terraform.

5.Secure API Access – Ensures controlled access to cost data.

## Technology Used

1.AWS Lambda – Fetch AWS cost data via Cost Explorer.

2.API Gateway – Expose cost data via a REST API.

3.Amazon S3 – Host the frontend dashboard.

4.AWS CloudWatch – Monitor logs and set up alerts.

5.Amazon SNS – Send cost alerts via email.

6.Terraform – Automate infrastructure deployment.

7.JavaScript (Frontend) – Interactive dashboard with real-time data fetching.

## Use Case 

For businesses and startups, this platform enables efficient tracking and management of cloud expenses. Cloud engineers and DevOps teams can monitor AWS costs in real-time, ensuring optimized resource usage. Finance and IT departments benefit from the system’s ability to optimize the AWS budget, preventing overspending and driving cost efficiency.

##  Prerequisites

1.AWS Account with necessary permissions.

2.Terraform Installed on your local machine.

3.AWS CLI Configured with required IAM roles.

4.Node.js & NPM for frontend modifications

## Step 1: Clone the Repository

1.1.Clone this repository to your local machine

```language

git clone https://github.com/Tatenda-Prince/AWS-Cloud-Cost-Optimization-Insights-Platform-.git

```



## Step 2 : Run Terraform workflow to initialize, validate, plan then apply

2.1.Lets deploy backend (Lambda, API Gateway, CloudWatch)


2.2.In your local terraform visual code environment terminal, to initialize the necessary providers, execute the following command in your environment terminal —

```language
terraform init

```


![image_alt](https://github.com/Tatenda-Prince/AWS-Cloud-Cost-Optimization-Insights-Platform-/blob/b58b0c1ce2bcd99850bd9916db51ccc98c26b116/img/Screenshot%202025-02-22%20133239.png)


Upon completion of the initialization process, a successful prompt will be displayed, as shown below.


2.3.Next, let’s ensure that our code does not contain any syntax errors by running the following command —

```language
terraform validate

```

The command should generate a success message, confirming that it is valid, as demonstrated below.


![image_alt](https://github.com/Tatenda-Prince/AWS-Cloud-Cost-Optimization-Insights-Platform-/blob/a3182760e2204ac72fcf2fa7fc84ea62839f72b9/img/Screenshot%202025-02-22%20133358.png)


2.5.Let’s now execute the following command to generate a list of all the modifications that Terraform will apply. —


```language
terraform plan

```

![image_alt](https://github.com/Tatenda-Prince/AWS-Cloud-Cost-Optimization-Insights-Platform-/blob/00aa0ea8d99204a6e4eac8d8cb30dea5f9f78483/img/Screenshot%202025-02-22%20133541.png)

The list of changes that Terraform is anticipated to apply to the infrastructure resources should be displayed. The “+” sign indicates what will be added, while the “-” sign indicates what will be removed.


2.6.Now, let’s deploy this infrastructure! Execute the following command to apply the changes and deploy the resources.


Note — Make sure to type “yes” to agree to the changes after running this command


```language
terraform apply

```

Terraform will initiate the process of applying all the changes to the infrastructure. Kindly wait for a few seconds for the deployment process to complete.

![image_alt](https://github.com/Tatenda-Prince/AWS-Cloud-Cost-Optimization-Insights-Platform-/blob/9131c7fbe5b99213ecf0bbbb1b8a5139abeeb288/img/Screenshot%202025-02-22%20133829.png)


## Success!

The process should now conclude with a message indicating “Apply complete”, stating the total number of added, modified, and destroyed resources, accompanied by several resources.

![image_alt](https://github.com/Tatenda-Prince/AWS-Cloud-Cost-Optimization-Insights-Platform-/blob/068d8f3ecdcbcac54632c6e3f69cae31111752b1/img/Screenshot%202025-02-22%20134159.png)


## Step 3: Verify creation of AWS Lambda, Amazon S3 , AWS API Gateway

3.1.In the AWS Management Console, head to the Amazon Lambda dashboard and verify that the aws-cost-fecter function was successfully created

![image_alt](https://github.com/Tatenda-Prince/AWS-Cloud-Cost-Optimization-Insights-Platform-/blob/4b192b78659e5dbd5b445964f871af768706fb41/img/Screenshot%202025-02-21%20202937.png)

## Lets Test our lambda Function 

3.1.1.Test the Lambda function:

Go to AWS Lambda Console → Find `aws-cost-fetcher`

Click Test → Select "`Create new test event`" → Leave it empty → `Run the test`

![image_alt](https://github.com/Tatenda-Prince/AWS-Cloud-Cost-Optimization-Insights-Platform-/blob/ceb6545e868136bd6e40b411af0960dc68c3ac11/img/Screenshot%202025-02-22%20135711.png)



3.2.In the AWS Management Console, head to the Amazon S3 dashboard and verify that the aws-cost-dashboard Table was successfully created

![image_alt](https://github.com/Tatenda-Prince/AWS-Cloud-Cost-Optimization-Insights-Platform-/blob/940c9f7f73d623be919d6c10fcff3c10caf1596b/img/Screenshot%202025-02-21%20202947.png)


3.3.In the AWS Management Console, head to the API Gateway dashboard and verify that the CostDataAPI was successfully created



![image_alt](https://github.com/Tatenda-Prince/AWS-Cloud-Cost-Optimization-Insights-Platform-/blob/92f356d4cda9dc6f5902f4d6a4ccf464949ccdbe/img/Screenshot%202025-02-21%20203732.png)


## lets Test our API Gateway in browser

Note: Before you deploy your API first Enable `CORS` on your `Resource` this will allow your frontend to communicate with the backend.

Paste the API URL into your browser and hit Enter. You should see a JSON response with cost data.

`https://y9dcmyma4f.execute-api.us-east-1.amazonaws.com/prod/cost`

![image_alt]()



## Step 4: Deploy Frontend (S3 & Hosting)

4.1.Open your AWS CLI Command line up upload the file to your S3 bucket 

Note: On the `script.js` file replace the `const apiUrl = "https://y9dcmyma4f.execute-api.us-east-1.amazonaws.com/prod/cost";`  // Replace with your API Gateway URL

```language
aws s3 cp index.html s3://tatenda-aws-cost-dashboard/

aws s3 cp script.js s3://tatenda-aws-cost-dashboard/

aws s3 cp style.css s3://tatenda-aws-cost-dashboard/
```


## Step 5: lets test the Dashboard

5.1.Go to the AWS Console → S3

5.2.Find your bucket (`tatenda-aws-cost-dashboard`)

5.3.Go to "Properties" → Scroll down to Static Website Hosting

5.4.Find the "Bucket Website Endpoint", which looks like:

```language
http://tatenda-aws-cost-dashboard.s3-website-us-east-1.amazonaws.com

```

5.5.Open the S3 Bucket URL in your browser.

You should be able to dashboard web page 

![image_alt]()



5.6.Click Load Cost Data and verify API responses.

You should be able to see the results on the dashboard 

![image_alt]()


## Future Enhancements

1.We are going to create metric alarm that will trigger SNS whenever a certain resource has exceeds above the threshold.

2.Multi-Account Support – Track costs across multiple AWS accounts.


## Congratulations

We have successfully created "AWS Cloud Cost Optimization and Inssights Platform" helps businesses track AWS spending in real-time, receive alerts for unusual activity, and optimize cloud resources effectively. With this solution, companies can reduce costs, prevent unexpected billing issues, and make data-driven cloud decisions.

























