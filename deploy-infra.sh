#!/bin/bash

# ===========================
# Capstone Project Deployment Script
# Author: Paulina Agoudavi
# Description: Automates Azure static website deployment
# ===========================

# Step 1: Variables
RESOURCE_GROUP="capstone-rg"
LOCATION="eastus"
STORAGE_ACCOUNT="capstonestorage$RANDOM"

echo "Starting Azure resource deployment..."
echo "Resource Group: $RESOURCE_GROUP"
echo "Location: $LOCATION"
echo "Storage Account: $STORAGE_ACCOUNT"

# Step 2: Create Resource Group
echo "Creating resource group..."
az group create --name $RESOURCE_GROUP --location $LOCATION

# Step 3: Create Storage Account
echo "Creating storage account..."
az storage account create \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_LRS \
  --kind StorageV2

# Step 4: Enable static website hosting
echo "Enabling static website hosting..."
az storage blob service-properties update \
  --account-name $STORAGE_ACCOUNT \
  --static-website \
  --index-document index.html \
  --404-document 404.html

# Step 5: Get the website URL
echo "Fetching website URL..."
az storage account show \
  --name $STORAGE_ACCOUNT \
  --query "primaryEndpoints.web" \
  --output tsv

# Step 6: Upload website files
echo "Uploading website files to Azure..."
az storage blob upload-batch \
  --account-name $STORAGE_ACCOUNT \
  --destination '$web' \
  --source ./website

echo "Website files uploaded successfully!"

# Step 7: Display the live site URL again
WEB_URL=$(az storage account show --name $STORAGE_ACCOUNT --query "primaryEndpoints.web" --output tsv)
echo "Your static website is now live at: $WEB_URL"

# Step 8: Create Virtual Network and Subnet
echo "Creating Virtual Network and Subnet..."
az network vnet create \
  --resource-group $RESOURCE_GROUP \
  --name capstoneVNet \
  --address-prefix 10.0.0.0/16 \
  --subnet-name capstoneSubnet \
  --subnet-prefix 10.0.1.0/24 \
  --location eastus \

# Step 9: Create Network Security Group
echo "Creating Network Security Group..."
az network nsg create \
  --resource-group $RESOURCE_GROUP \
  --name capstoneNSG \
  --location eastus

  # Allow SSH (port 22) inbound access
az network nsg rule create \
  --resource-group $RESOURCE_GROUP \
  --nsg-name $NSG_NAME \
  --name Allow-SSH \
  --protocol tcp \
  --priority 3 \
  --destination-port-ranges 22 \
  --access allow


# Step 10: Create a Linux Virtual Machine
echo "Creating Virtual Machine..."
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name capstoneVM \
  --image Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest \
  --size Standard_B1s \
  --vnet-name capstoneVNet \
  --subnet capstoneSubnet \
  --nsg capstoneNSG \
  --location eastus \
  --public-ip-sku Standard \
  --admin-username azureuser \
  --generate-ssh-keys \


echo "VM and network infrastructure created successfully!"
