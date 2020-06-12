docker build -t marklovely67/multiclient:latest -t marklovely67/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t makrlovely67/multi-server:latest -t -t makrlovely67/multi-server:$SHA -f .server/Dockerfile ./server
docker build -t makrlovely67/multi-worker:latest -t makrlovely67/multi-worker:$SHA -f .worker/Dockerfile ./worker

docker push marklovely67/multi-client:latest
docker push marklovely67multi-server:latest
docker push marklovely67/multi-worker:latest

docker push marklovely67/multi-client:$SHA
docker push marklovely67multi-server:$SHA
docker push marklovely67/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image/deployments/server-deployment server=marklovely67/multi-server:$SHA
kubectl set image/deployments/client-deployment client=marklovely67/multi-client:$SHA
kubectl set image/deployments/worker-deployment worker=marklovely67/multi-worker:$SHA