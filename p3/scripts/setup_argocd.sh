
# Create k3d cluster
sudo k3d cluster create -p 8080:80@loadbalancer -p 8888:30888@loadbalancer
sleep 3

# Install argocd
sudo kubectl create namespace dev
sudo kubectl create namespace argocd
sleep 3

sudo kubectl apply -f /vagrant/confs/argocd_install.yaml -n argocd
sleep 3

sudo kubectl wait --for=condition=Ready pods --all -n argocd
sleep 3

# Apply ingress
sudo kubectl apply -f /vagrant/confs/argocd_ingress.yaml -n argocd
sleep 3

# Apply project and application
sudo kubectl apply -f /vagrant/confs/project.yaml -n argocd
sleep 3
sudo kubectl apply -f /vagrant/confs/application.yaml -n argocd
sleep 3

echo "ArgoCD is ready at http://localhost:8080"
echo "Username: admin"
echo "Password: $(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"

