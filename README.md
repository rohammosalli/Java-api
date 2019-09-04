[![Build Status](https://travis-ci.org/rohammosalli/simple-java-api.svg?branch=master)](https://travis-ci.org/rohammosalli/simple-java-api)


### Part I - Simple Java API
#### About the System 

This image can show you the overview of the system 

![alt text](https://github.com/rohammosalli/Java-api/blob/master/GKE.jpg "GKE overview")


This Image can show you the overview of CI CD process 

![alt text](https://github.com/rohammosalli/Java-api/blob/master/CICD.png "CICD overview")

### How to run

This application able to run from docker so you can run it with below command and it will run on your system :) be sure you have docker and  docker-compose installed.

```bash 

   docker-compose up -d
```

Application listens on port 4567.


### Part II - CI /CD
#### Travis

I will use travis for CI/CD process, we need defined  some env GCLOUD_SERVICE_KEY private ENVIRONMENT VARIABLES to make access to GKE. I have been choose travis because I think when everything is on the cloud it's good idea if I use travis, but we can trigger other CI/CD tool like (Jenkins, GitlabCI) with webhooks in GITHUB.

I wrote some unit tests which cover my application functionalities so I run it in CI section and after that Deploy it to GKE(Google Cloud Kubernetes Service) if tests were successful.

#### NOTE: 

There is no need to manual work to deploy, if you merge or commit to master branch it will test and deploy on cloud and if you push to development branch it just run tests and show in merge request status, In this project I used github flow also after successful/failure deployment we receive email for it



### Infrastructure as Code

I choose Terraform for provision our infrastructure because it has big community and it's stable to now. Actually we have no manual work even for implement our production environment, here we go


 Step 1 ( Install Terraform ):

Download terraform from below link and extend path to your bash path variable Download [HERE](https://www.terraform.io/downloads.html)

###### Step 2 
( Download Google Cloud Service Key and Enable kubernetes API )

We need a way for the Terraform runtime to authenticate with the GCP API so go to the Cloud Console, navigate to IAM & Admin > Service Accounts, and click Create Service Account with Project Editor role. Your browser will download a JSON file containing the details of the service account and a private key that can authenticate as a project editor to your project. Keep this JSON file safe!

```bash
cd deployment/iac
mkdir creds
cp DOWNLOADEDSERVICEKEY.json creds/serviceaccount.json
```
then just run this command inside terraform folder 

```bash

terraform plan

terraform apply

```
###### Step 3 ( Deploy GKE Cluster )

Set your project name and location in provider.tf and .travis.yml then Deploy
you can find this file in deploy/terraform folder 
terraform apply


### Note (SRE aspect)

1 - the most common SRE aspect for zero downtime says we can use Blue/Green or Canary or rolling update to make out app HA since I use Kubernetes I will use a rolling update