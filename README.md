# Devops-infra-pipeline

1. TERRAFORM steps:

Initialize Terraform:
terraform init

Formatting Terraform:
terraform fmt

Validate the config:
terraform validate

Apply:
terraform apply

Confirm with yes when prompted.

If you want to skip this prompt automatically next time, you can use:
terraform apply -auto-approve


2. Deploy NGINX app

Create NGINX manifest in manifests/nginx-deployment.yaml

Apply:
kubectl apply -f manifests/nginx-deployment.yaml
kubectl get pods
kubectl get svc nginx-service

Access in browser:

kubectl port-forward svc/nginx-service 8080:80

Visit: http://localhost:8080
You’ll see “Welcome to nginx!”

3. Deploy ARGOCD

Install ArgoCD:
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

Port-forward ArgoCD server:
kubectl port-forward svc/argocd-server -n argocd 8081:443

Access UI: http://localhost:8081

Get ArgoCD admin password:
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d && echo
Login: admin / <password>

Create argocd/nginx-app.yaml
Apply:

kubectl apply -f argocd/nginx-app.yaml
Go to ArgoCD UI → Applications → nginx-app → Sync → you’ll see your NGINX pod.

Verify GitOps:
-> Make a change in nginx-deployment.yaml — e.g., replicas: 2 → 3
-> Change repo URL in nginx-app.yaml
-> Commit & push.
-> ArgoCD auto-syncs → Pod count changes to 3.

How to check that it worked
Run:
kubectl get deployment

Open https://localhost:8081

Log in → click your nginx-app

Click Refresh 🔄 (top right)

Click SYNC → SYNCHRONIZE






