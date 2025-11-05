#!/bin/bash
# deploy.sh – Automate web server setup and website deployment

RESOURCE_GROUP="capstone-rg"
VM_NAME="capstoneVM"
ADMIN_USER="azureuser"
LOCAL_WEB_DIR="website"
REMOTE_DIR="/var/www/html"
PUBLIC_IP=$(az vm show -d -g $RESOURCE_GROUP -n $VM_NAME --query publicIps -o tsv)

echo "Connecting to VM ($PUBLIC_IP) and setting up web server..."

# Install NGINX and deploy files on the remote VM
ssh -o StrictHostKeyChecking=no $ADMIN_USER@$PUBLIC_IP <<'ENDSSH'
  sudo apt update -y
  sudo apt install nginx -y
  sudo rm -rf /var/www/html/*
  exit
ENDSSH

# Copy website files
scp -r $LOCAL_WEB_DIR/* $ADMIN_USER@$PUBLIC_IP:$REMOTE_DIR

# Restart NGINX
ssh $ADMIN_USER@$PUBLIC_IP "sudo systemctl restart nginx"

echo "✅ Deployment complete! Visit your website at: http://$PUBLIC_IP"
