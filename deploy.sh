docker build -t dhananjay12/multi-client:latest -t dhananjay12/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dhananjay12/multi-server:latest -t dhananjay12/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dhananjay12/multi-worker:latest -t dhananjay12/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dhananjay12/multi-client:latest
docker push dhananjay12/multi-server:latest
docker push dhananjay12/multi-worker:latest

docker push dhananjay12/multi-client:$SHA
docker push dhananjay12/multi-server:$SHA
docker push dhananjay12/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dhananjay12/multi-server:$SHA
kubectl set image deployments/client-deployment client=dhananjay12/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dhananjay12/multi-worker:$SHA