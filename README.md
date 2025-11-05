🌐 Capstone Static Website Deployment on Azure
📖 Project Overview

This project demonstrates the end-to-end process of deploying a static website on Microsoft Azure using Infrastructure as Code (IaC) principles.
The deployment is fully automated using Bash scripts, leveraging the Azure CLI for infrastructure creation and Nginx for web hosting on an Ubuntu virtual machine.

The goal of this project is to showcase proficiency in cloud infrastructure automation, resource management, DevOps scripting, and continuous documentation.

🧱 Project Architecture

The following Azure resources were created and configured:

Resource Group – Logical container for all project resources.

Virtual Network (VNet) – Provides secure network communication between resources.

Subnet – Isolated segment within the VNet.

Network Security Group (NSG) – Controls inbound/outbound network traffic (port 22 for SSH, port 80 for HTTP).

Public IP Address – Enables external access to the web server.

Virtual Machine (Ubuntu) – Hosts the static website using Nginx web server.

⚙️ Automation Scripts
1. deploy_infra.sh

This script automates the creation of all necessary Azure infrastructure components.
It creates:

A resource group

A virtual network and subnet

A network security group with SSH and HTTP rules

A public IP address

A Linux virtual machine

✅ Command example:

bash deploy_infra.sh

2. deploy.sh

This script automates the configuration and deployment of the static website to the Azure VM.
It installs Nginx, configures the web root directory, and uploads the website files.

✅ Command example:

bash deploy.sh

🧩 Website Structure
website/
├── index.html          # Main webpage
├── css/
│   └── style.css       # Styling for the site          

📘 Documentation

All project progress, commands, and notes were recorded in:

notes/steps.txt


Each step details:

Commands executed

Challenges faced (e.g., connection timeouts, permission issues)

Solutions implemented

Screenshots captured for verification

🧾 Folder Structure
capstone-static-site-project/
│
├── deploy.sh
├── deploy_infra.sh
│
├── notes/
│   └── steps.txt
│
├── website/
│   ├── index.html
│   └── css/style.css
│
├── screenshots/
│   ├── step1.png
│   ├── step2.png
│   ├── step3.png
│   ├── step4.png
│   ├── step5.png
│   └── step6.png
│
└── README.md

🚀 Deployment Verification

After deployment:

Verified access to the Azure VM via SSH.

Confirmed successful Nginx installation and web server configuration.

Tested public IP in browser to confirm live website availability.

Verified correct display of static content (HTML and CSS).

🧰 Tools and Technologies Used
Tool	Purpose
Azure CLI	Resource creation and management
Bash Scripting	Infrastructure and deployment automation
Nginx	Static site web server
Git & GitHub	Version control and documentation
VS Code	Development environment
📸 Screenshots

Screenshots of each major milestone were saved in the screenshots/ folder to provide visual evidence of successful configuration and deployment.

🧠 Lessons Learned

Automating resource creation via Bash saves time and ensures consistency.

Common connection issues (SSH timeouts, NSG rules) can be debugged with Azure CLI commands.

Proper directory structure and documentation improve clarity and reproducibility.

Pushing incremental changes to GitHub prevents data loss during large projects.

🏁 Final Outcome

A fully functional static website hosted on Azure, deployed through automated scripts, and documented with detailed notes and screenshots.
This project demonstrates the practical application of DevOps fundamentals — automation, cloud provisioning, and version-controlled deployment.
