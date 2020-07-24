#!/bin/bash

project_gcp="robotic-tide-284315"
email="allanasodreferreira@gmail.com"

gcloud container clusters get-credentials gke-test-1 --region us-east1 --project $project_gcp

kubectl create clusterrolebinding user-admin-binding \
    --clusterrole=cluster-admin --user=$email

kubectl create clusterrolebinding --clusterrole=cluster-admin \
    --serviceaccount=default:default spinnaker-admin

./helm repo add stable https://kubernetes-charts.storage.googleapis.com

./helm repo update