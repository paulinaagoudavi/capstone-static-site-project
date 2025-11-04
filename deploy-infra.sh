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
