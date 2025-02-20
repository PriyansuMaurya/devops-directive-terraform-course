# Ensure script stops on errors
$ErrorActionPreference = "Stop"

# Change directory to example
Set-Location -Path "../../examples/hello-world"

# Initialize and apply Terraform configuration
terraform init
terraform apply -auto-approve

# Wait while the instance boots up
Start-Sleep -Seconds 60

# Query the output, extract the IP and make a request
$instanceIP = (terraform output -json | ConvertFrom-Json).instance_ip_addr.value

if ($instanceIP) {
    try {
        Invoke-WebRequest -Uri "http://$instanceIP:8080" -TimeoutSec 10
        # If request succeeds, destroy the resources
        terraform destroy -auto-approve
    } catch {
        Write-Error "Request to the instance failed."
    }
} else {
    Write-Error "Failed to retrieve instance IP address."
}
