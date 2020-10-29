docker build -t ahmdocker/multi-client:latest -t ahmdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ahmdocker/multi-server:latest -t ahmdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ahmdocker/multi-worker:latest -t ahmdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ahmdocker/multi-client:latest
docker push ahmdocker/multi-server:latest
docker push ahmdocker/multi-worker:latest

docker push ahmdocker/multi-client:$SHA
docker push ahmdocker/multi-server:$SHA
docker push ahmdocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ahmdocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=ahmdocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ahmdocker/multi-worker:$SHA