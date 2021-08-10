
#1 Logearse a su cuenta con el azure portal
az login
#2 Crearse un Service Principal
az ad sp create-for-rbac --name ucreativa_microservicios
#3 Este comando les dará un output similar a este:
```
{
  "appId": "12fb6e37-e650-4ea1-b2aa-d71abae4ea4f",
  "displayName": "ucreativa_microservicios",
  "name": "12fb6e37-e650-4ea1-b2aa-c71abae4ea4d",
  "password": "JcZM7hESKv9lJnLm_IGQYd46L1gP-XXX-X",
  "tenant": "319e7e16-a8cd-486e-a332-dc87c10cedcf"
}
```
#4 Deslogearse de su cuenta
az logout
#5 Connectarse con el service principal (REMPLACEN con sus datos)
az login --service-principal \
         --username 12fb6e37-e650-4ea1-b2aa-d71abae4ea4f  \
         --password "JcZM7hESKv9lJnLm_IGQYd46L1gP-XXX-X"  \
         --tenant 319e7e16-a8cd-486e-a332-dc87c10cedcf
#6 Revisar lista de cuentas que tienen disponible
az account list
#7 Revisar lista disponible de locaciones
az account list-locations --query '[].name'
#8 Crear Resource Group
az group create -l southcentralus -n dev-clase09-rg
#9 Crear cluster de k8s
az aks create -g dev-clase09-rg -n CoolCluster --node-count 2
#10 Ver lista de Clusters creados
az aks list -o table
#11 Ir al cluster en el Azure Portal
az aks browse -n CoolCluster -g dev-clase09-rg
#12 Actualizar su ~/.kube/config para conectarse con kubectl
az aks get-credentials -g dev-clase09-rg -n CoolCluster
#13 Ver lista de NodePools
az aks nodepool list  --cluster-name CoolCluster --resource-group dev-clase09-rg
#14 Escalar su cluster a 1 nodo
az aks nodepool scale --cluster-name CoolCluster --name nodepool1 --resource-group dev-clase09-rg --node-count 1
#15 Agregar otro Nodepool
az aks nodepool add \
    --resource-group dev-clase09-rg \
    --cluster-name CoolCluster \
    --name otro \
    --node-count 1
#16 Crear deployment con python-service
kubectl apply -f k8s/hola-deployment.yml
#17 Crear service para poder accesar python-service
kubectl apply -f k8s/hola-svc.yml
#18 Obtener IP Publica del svc
kubectl get svc
#19 Ir al Servicio expuesto en la nube
http://[IP Publico del Load Balancer]/hello
#20 Eliminar todo
az aks delete -n CoolCluster -g dev-clase09-rg
az group delete -n dev-clase09-rg