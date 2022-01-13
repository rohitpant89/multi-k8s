docker build -t rohitpan89/multi-client:latest -t rohitpan89/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rohitpan89/multi-server:latest -t rohitpan89/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rohitpan89/multi-worker:latest -t rohitpan89/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rohitpan89/multi-client:$SHA 
docker push rohitpan89/multi-server:$SHA
docker push rohitpan89/multi-worker:$SHA
docker push rohitpan89/multi-client:latest
docker push rohitpan89/multi-server:latest
docker push rohitpan89/multi-worker:latest

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=rohitpan89/multi-server:$SHA
kubectl set image deployments/client-deployment server=rohitpan89/multi-client:$SHA
kubectl set image deployments/worker-deployment server=rohitpan89/multi-worker:$SHA
