#!/bin/bash
# ==========================================
# Capstone Project Infrastructure Automation
# ==========================================

# Variables
RESOURCE_GROUP="capstone-rg"
LOCATION="eastus"
VNET_NAME="capstoneVNet"
SUBNET_NAME="capstoneSubnet"
NSG_NAME="capstoneNSG"
PUBLIC_IP_NAME="capstoneVMPublicIP"
NIC_NAME="capstoneVMVMNic"
VM_NAME="capstoneVM"
USERNAME="azureuser"

# Step 1: Create Resource Group
echo "Creating Resource Group..."
az group create --name $RESOURCE_GROUP --location $LOCATION

# Step 2: Create Virtual Network
echo "Creating Virtual Network..."
az network vnet create \
  --resource-group $RESOURCE_GROUP \
  --name $VNET_NAME \
  --address-prefix 10.0.0.0/16 \
  --subnet-name $SUBNET_NAME \
  --subnet-prefix 10.0.1.0/24

# Step 3: Create Network Security Group
echo "Creating Network Security Group..."
az network nsg create \
  --resource-group $RESOURCE_GROUP \
  --name $NSG_NAME

# Step 4: Create NSG Rules
echo "Creating NSG Rules..."
az network nsg rule create \
  --resource-group $RESOURCE_GROUP \
  --nsg-name $NSG_NAME \
  --name Allow-SSH \
  --protocol tcp --priority 1000 \
  --destination-port-ranges 22 \
  --access Allow

az network nsg rule create \
  --resource-group $RESOURCE_GROUP \
  --nsg-name $NSG_NAME \
  --name Allow-HTTP \
  --protocol tcp --priority 200 \
  --destination-port-ranges 80 \
  --access Allow

# Step 5: Create Public IP
echo "Creating Public IP..."
az network public-ip create \
  --resource-group $RESOURCE_GROUP \
  --name $PUBLIC_IP_NAME \
  --sku Standard \
  --allocation-method Dynamic

# Step 6: Create Network Interface
echo "Creating Network Interface..."
az network nic create \
  --resource-group $RESOURCE_GROUP \
  --name $NIC_NAME \
  --vnet-name $VNET_NAME \
  --subnet $SUBNET_NAME \
  --network-security-group $NSG_NAME \
  --public-ip-address $PUBLIC_IP_NAME

# Step 7: Create Virtual Machine
echo "Creating Virtual Machine..."
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name $VM_NAME \
  --image Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest \
  --size Standard_B1s \
  --admin-username $USERNAME \
  --generate-ssh-keys \
  --nics $NIC_NAME

# Step 8: Output Public IP
echo "Getting Public IP Address..."
az vm list-ip-addresses \
  --resource-group $RESOURCE_GROUP \
  --name $VM_NAME \
  --output table

echo "✅ Infrastructure creation complete!"
