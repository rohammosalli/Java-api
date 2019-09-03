[![Build Status](https://travis-ci.org/rohammosalli/simple-java-api.svg?branch=master)](https://travis-ci.org/rohammosalli/simple-java-api)


### Part I - Simple Java API
#### About the System 

There is two way to run application on your own system .

### How to run

This application able to run from docker so you can run it with below command and it will run on your system :) be sure you have docker and  docker-compose installed.

```bash    docker-compose up -d ```

Application listens on port 4567.


### Part II - CI /CD
#### Travis

I used travis for CI/CD process and defined  GCLOUD_SERVICE_KEY private ENVIRONMENT VARIABLES on it. I have been choose travis because I know it very good and it meets bonus point by itself but we can trigger other CI/CD tool like (Jenkins, GitlabCI) with webhooks in GITHUB.

I wrote some unit tests which cover my application functionalities so I run it in CI section and after that Deploy it to GKE(Google Cloud Kubernetes Service) if tests were successful.

NOTE: There is no need to manual work to deploy, if you merge or commit to master branch it will test and deploy on cloud and if you push to development branch it just run tests and show in merge request status, In this project I used github flow also after successful/failure deployment we receive email for it


