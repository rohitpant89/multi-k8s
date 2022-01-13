docker build -t rohitpant89/multi-client:latest -t rohitpant89/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rohitpant89/multi-server:latest -t rohitpant89/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rohitpant89/multi-worker:latest -t rohitpant89/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rohitpant89/multi-client:$SHA 
docker push rohitpant89/multi-server:$SHA
docker push rohitpant89/multi-worker:$SHA
docker push rohitpant89/multi-client:latest
docker push rohitpant89/multi-server:latest
docker push rohitpant89/multi-worker:latest

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=rohitpant89/multi-server:$SHA
kubectl set image deployments/client-deployment server=rohitpant89/multi-client:$SHA
kubectl set image deployments/worker-deployment server=rohitpant89/multi-worker:$SHA