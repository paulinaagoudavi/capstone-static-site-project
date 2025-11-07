name: Ì∫Ä Deploy Static Website to Azure VM

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      # Step 1Ô∏è‚É£ ‚Äî Checkout your repository code
      - name: Checkout code
        uses: actions/checkout@v4

      # Step 2Ô∏è‚É£ ‚Äî Set up SSH agent with your private key
      - name: Set up SSH
        uses: webfactory/ssh-agent@v0.9.0
        with:
          ssh-private-key: ${{ secrets.AZURE_VM_SSH_KEY }}

      # Step 3Ô∏è‚É£ ‚Äî Verify SSH connection to Azure VM
      - name: Test SSH Connection
        run: |
          echo "Ì¥ç Testing connection to VM..."
          ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 ${{ secrets.AZURE_VM_USER }}@${{ secrets.AZURE_VM_IP }} "echo '‚úÖ Connection successful!'"

      # Step 4Ô∏è‚É£ ‚Äî Copy website files to the VM
      - name: Upload website files to Azure VM
        run: |
          echo "Ì≥Ç Uploading website files to /var/www/html/ ..."
          scp -o StrictHostKeyChecking=no -r website/* ${{ secrets.AZURE_VM_USER }}@${{ secrets.AZURE_VM_IP }}:/var/www/html/

      # Step 5Ô∏è‚É£ ‚Äî Restart NGINX on the VM
      - name: Restart NGINX service
        run: |
          echo "Ì¥Å Restarting NGINX..."
          ssh -o StrictHostKeyChecking=no ${{ secrets.AZURE_VM_USER }}@${{ secrets.AZURE_VM_IP }} "sudo systemctl restart nginx"

      # Step 6Ô∏è‚É£ ‚Äî Confirm Deployment
      - name: Deployment complete
        run: echo "‚úÖ Deployment successful! Visit: http://${{ secrets.AZURE_VM_IP }}"
