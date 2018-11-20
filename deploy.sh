#!/usr/bin/env bash

docker build -t karthik047/multi-client:latest -t karthik047/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t karthik047/multi-server:latest -t karthik047/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t karthik047/multi-worker:latest -t karthik047/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push karthik047/multi-client:latest
docker push karthik047/multi-client:$SHA

docker push karthik047/multi-server:latest
docker push karthik047/multi-server:$SHA

docker push karthik047/multi-worker:latest
docker push karthik047/multi-worker:$SHA

kubectl apply -f k8s

#Increment updates to the builds - Imperative command
kubectl set image deployments/server-deployment server=karthik047/multi-server:$SHA
kubectl set image deployments/client-deployment client=karthik047/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=karthik047/multi-worker:$SHA