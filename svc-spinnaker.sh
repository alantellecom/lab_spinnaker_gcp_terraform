
#### ingress 

#kubectl patch svc spin-deck -p '{"spec": {"type": "NodePort"}}'

#kubectl patch svc spin-gate -p '{"spec": {"type": "NodePort"}}'

#kubectl exec --namespace default -it cd-spinnaker-halyard-0 bash

#hal deploy apply

#kubectl apply -f ingress.yml



#### Load Balance

kubectl -n default expose svc spin-deck --type LoadBalancer --port 80 --target-port 9000 --name spin-deck-public

kubectl -n default expose svc spin-gate --type LoadBalancer --port 80 --target-port 8084 --name spin-gate-public