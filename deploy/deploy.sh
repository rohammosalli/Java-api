set -e

#docker build -t gcr.io/${PROJECT_NAME_STG}/${DOCKER_IMAGE_NAME}:$TRAVIS_COMMIT .
docker build -t gcr.io/${PROJECT_NAME}/revolut:$TRAVIS_COMMIT .
docker tag gcr.io/${PROJECT_NAME}/revolut:$TRAVIS_COMMIT gcr.io/${PROJECT_NAME}/revolut:latest


echo $GCLOUD_SERVICE_KEY_STG | base64 --decode -i > ${HOME}/gcloud-service-key.json
gcloud auth activate-service-account --key-file ${HOME}/gcloud-service-key.json

gcloud --quiet config set project $PROJECT_NAME
gcloud --quiet config set container/cluster $CLUSTER_NAME
gcloud --quiet config set compute/zone ${CLOUDSDK_COMPUTE_ZONE}
gcloud --quiet container clusters get-credentials $CLUSTER_NAME

yes | gcloud auth configure-docker
docker push gcr.io/${PROJECT_NAME}/revolut


yes | gcloud beta container images add-tag gcr.io/${PROJECT_NAME}/revolut:$TRAVIS_COMMIT gcr.io/${PROJECT_NAME}/revolut:latest

kubectl config view
kubectl config current-context


sed -i "s/PROJECTNAME/$PROJECT_NAME/g" ./deploy/deployment.yaml
sed -i "s/TRAVIS_COMMIT/$TRAVIS_COMMIT/g" ./deploy/deployment.yaml

kubectl apply -f ./deploy/deployment.yaml
kubectl get svc 