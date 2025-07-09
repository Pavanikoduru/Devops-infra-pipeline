#DevOps Infra Pipeline Steps

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

<img width="956" alt="image" src="https://github.com/user-attachments/assets/e29dfcc3-bc49-478a-8e1a-13ba900b5dd1" />

3. Deploy ARGOCD

Install ArgoCD:

kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

Port-forward ArgoCD server:

kubectl port-forward svc/argocd-server -n argocd 8081:443

Access UI: http://localhost:8081

<img width="959" alt="image" src="https://github.com/user-attachments/assets/91692d2e-405e-47cc-9446-e810968935ca" />

Get ArgoCD admin password:

kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d && echo

Login: admin / <password>

Create argocd/nginx-app.yaml

Apply:

kubectl apply -f argocd/nginx-app.yaml

4. GitOps

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

<img width="959" alt="image" src="https://github.com/user-attachments/assets/77298b87-3b86-4887-ae13-c31fd5beab8c" />

