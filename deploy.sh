docker build -t jfgf11/multi-client:latest -t jfgf11/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jfgf11/multi-server:latest -t jfgf11/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jfgf11/multi-worker:latest -t jfgf11/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jfgf11/multi-client:latest
docker push jfgf11/multi-server:latest
docker push jfgf11/multi-worker:latest
docker push jfgf11/multi-client:$SHA
docker push jfgf11/multi-server:$SHA
docker push jfgf11/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jfgf11/multi-server:$SHA
kubectl set image deployments/client-deployment client=jfgf11/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jfgf11/multi-worker:$SHA