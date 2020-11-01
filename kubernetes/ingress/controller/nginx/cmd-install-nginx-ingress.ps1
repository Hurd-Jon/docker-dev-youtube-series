$namespace = "ingress-nginx"

Write-Host -ForegroundColor Green "------------------------"
Write-Host -ForegroundColor Green "Setting up nginx ingress"
Write-Host -ForegroundColor Green "------------------------"

Write-Host -ForegroundColor Green "Remove existing namespace"
kubectl delete namespace $namespace

Write-Host -ForegroundColor Green "Create namespace for nginx ingress"
kubectl apply -f ./namespace.yaml

Write-Host -ForegroundColor Green "Create service account"
kubectl apply -f ./service-account.yaml -n $namespace
kubectl apply -f ./cluster-role.yaml -n $namespace
kubectl apply -f ./cluster-role-binding.yaml -n $namespace

Write-Host -ForegroundColor Green "Create config map"
kubectl apply -f ./configMap.yaml -n $namespace
kubectl apply -f ./custom-snippets.configmap.yaml -n $namespace

Write-Host -ForegroundColor Green "Add deployment and service"
kubectl apply -f ./deployment.yaml  -n $namespace
kubectl apply -f ./service.yaml  -n $namespace

#Write-Host -ForegroundColor Green "------------------------"
#Write-Host -ForegroundColor Green "   App Specific setup"
#Write-Host -ForegroundColor Green "------------------------"

#$app_namespace = "example-app"

#Write-Host -ForegroundColor Green "Create namespace for example-app"
#kubectl apply -f ./namespace-app.yaml

#Write-Host -ForegroundColor Green "Add TLS secret - into namespace of app that will use it"
#kubectl apply -f ./tls-secret.yaml 

#Write-Host -ForegroundColor Green "Create example app pod"
#kubectl apply -f ..\..\..\deployments\deployment.yaml -n $app_namespace

#Write-Host -ForegroundColor Green "Create example app service"
#kubectl apply -f ..\..\..\services\service.yaml -n $app_namespace

#Write-Host -ForegroundColor Green "Create ingress"
#kubectl apply -f ..\..\ingress-nginx-example.yaml -n $app_namespace