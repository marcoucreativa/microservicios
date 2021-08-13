
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

##
## Aqui comienzan los pasos que vimos en la clase 10
##

#6 Crear Resource Group
az group create -l southcentralus -n dev-clase10-rg
#7 Crear el Azure Container Registry
az acr create --resource-group dev-clase10-rg --name ucreativaregistryclase10 --sku Basic
#8 Cree la imagen que va a hacer deployment, recuerde que tiene que estar ubicado donde esta el código y el dockerfile
docker build --tag ucreativaregistryclase10.azurecr.io/holatest:1.0.0 .
#9 Haga Login al Container Registry
az acr login --name ucreativaregistryclase10
#10 Haga push de la imagen al registry
docker push ucreativaregistryclase10.azurecr.io/holatest:1.0.0
#11 Cree el cluster
# Recuerde aquí hay que proveer su username y password (Use el Service Principal)
# Note que estamos poniendo un label para estos nodos
az aks create -g dev-clase10-rg \
              -n Clase10Cluster \ 
              --node-count 1 \
              --nodepool-labels "processing=aqui" \
              --service-principal "12fb6e37-e650-4ea1-b2aa-c71abae4ea4d" \
              --client-secret "PpcRR8-aFVXgutVJZ.foIVR2cWtiviSeek" \
#12 Loggese con Kubectl
az aks get-credentials -g dev-clase10-rg -n Clase10Cluster
#13 Confirme que se logeo bien ejecutando cualquier comando de Kubectl
kubectl get no -o wide
#14 Instale el hola-deployment.yml
kubectl apply -f k8s/hola-deployment.yml
#15 Recuerde que puede monitorear el estado de su cluster en otra terminal asi:
while true; do kubectl get po -o wide; sleep 1; done
#16 Agregue otro Nodepool
az aks nodepool add --resource-group dev-clase10-rg \
                    --cluster-name Clase10Cluster \
                    --name otro \
                    --node-count 1
#17 Confirme que ambos nodos fueron creados, recuerde uno tiene un label el otro no
kubectl get no -o wide
#18 Cambie la cantidad de replicas en hola-deployment.yml en la linea 8 por 20 y note que todos los pods se mantienen en el mismo nodo
kubectl apply -f k8s/hola-deployment.yml
kubectl get po -o wide
#19 Si crea otro deployment con bastantes replicas veras que estos van al nodo que les da la gana
kubectl apply -f k8s/otro-deployment.yml
kubectl get po -o wide
#20 Borre el resource group y con esto TODO para que no le sigan cobrando ;)
az group delete -n dev-clase10-rg