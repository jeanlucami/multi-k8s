docker build -t lcsfreund/multi-client:latest -t lcsfreund/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lcsfreund/multi-server:latest -t lcsfreund/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lcsfreund/multi-worker:latest -t lcsfreund/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lcsfreund/multi-client:latest
docker push lcsfreund/multi-server:latest
docker push lcsfreund/multi-worker:latest

docker push lcsfreund/multi-client:$SHA
docker push lcsfreund/multi-server:$SHA
docker push lcsfreund/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=lcsfreund/multi-server:$SHA
kubectl set image deployments/client-deployment client=lcsfreund/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lcsfreund/multi-worker:$SHA

