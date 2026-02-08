#!/bin/bash
# Cloud CLI Tools Configuration
# AWS, Azure, Google Cloud Platform

# =============================================================================
# AWS CLI
# =============================================================================

if command -v aws &>/dev/null; then
    # AWS completion
    complete -C '/usr/local/bin/aws_completer' aws 2>/dev/null || true
    
    # AWS aliases
    alias awswho='aws sts get-caller-identity'
    alias awsls='aws configure list'
    alias awsprof='export AWS_PROFILE='
    alias awsreg='export AWS_REGION='
    
    # S3 aliases
    alias s3ls='aws s3 ls'
    alias s3cp='aws s3 cp'
    alias s3sync='aws s3 sync'
    alias s3rm='aws s3 rm'
    
    # EC2 aliases
    alias ec2ls='aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PublicIpAddress]" --output table'
    
    # Lambda aliases
    alias lambdals='aws lambda list-functions'
    alias lambdainv='aws lambda invoke --function-name'
fi

# =============================================================================
# AZURE CLI
# =============================================================================

if command -v az &>/dev/null; then
    # Azure completion
    source <(az completion bash) 2>/dev/null || true
    
    # Azure aliases
    alias azwho='az account show'
    alias azsubs='az account list --output table'
    alias azsub='az account set --subscription'
    alias azrgs='az group list --output table'
    alias azvms='az vm list --output table'
    alias azaks='az aks list --output table'
    
    # Quick login
    alias azlogin='az login'
    alias azlogout='az logout'
fi

# =============================================================================
# GOOGLE CLOUD (GCloud)
# =============================================================================

if command -v gcloud &>/dev/null || [ -d "$HOME/google-cloud-sdk" ]; then
    # Add gcloud to PATH if installed locally
    if [ -d "$HOME/google-cloud-sdk" ]; then
        export PATH="$HOME/google-cloud-sdk/bin:$PATH"
        source "$HOME/google-cloud-sdk/path.bash.inc" 2>/dev/null || true
        source "$HOME/google-cloud-sdk/completion.bash.inc" 2>/dev/null || true
    fi
    
    # GCloud aliases
    alias gcwho='gcloud config get-value account'
    alias gcproj='gcloud config get-value project'
    alias gcsetproj='gcloud config set project'
    alias gczones='gcloud compute zones list'
    alias gcinstances='gcloud compute instances list'
    alias gckube='gcloud container clusters list'
    
    # Auth aliases
    alias gclogin='gcloud auth login'
    alias gclogout='gcloud auth revoke'
    alias gctoken='gcloud auth print-access-token'
fi

# =============================================================================
# TERRAFORM
# =============================================================================

if command -v terraform &>/dev/null; then
    # Terraform completion
    complete -C /usr/bin/terraform terraform 2>/dev/null || true
    
    # Terraform aliases
    alias tf='terraform'
    alias tfi='terraform init'
    alias tfv='terraform validate'
    alias tfp='terraform plan'
    alias tfa='terraform apply'
    alias tfaa='terraform apply -auto-approve'
    alias tfd='terraform destroy'
    alias tfo='terraform output'
    alias tfs='terraform show'
    alias tff='terraform fmt'
    alias tfw='terraform workspace'
    alias tfwl='terraform workspace list'
    alias tfws='terraform workspace select'
    alias tfwn='terraform workspace new'
    alias tfstate='terraform state'
    alias tfimport='terraform import'
fi

# =============================================================================
# ANSIBLE
# =============================================================================

if command -v ansible &>/dev/null; then
    # Ansible aliases
    alias an='ansible'
    alias anp='ansible-playbook'
    alias ang='ansible-galaxy'
    alias anv='ansible-vault'
    alias anping='ansible all -m ping'
    alias anfacts='ansible all -m setup'
fi

# =============================================================================
# DOCTL (DIGITAL OCEAN)
# =============================================================================

if command -v doctl &>/dev/null; then
    # Digital Ocean aliases
    alias doc='doctl'
    alias docc='doctl compute'
    alias dock='doctl kubernetes'
    alias docacct='doctl account get'
fi

# =============================================================================
# FUNCTIONS
# =============================================================================

# Switch AWS profile
aws-switch() {
    if [ -z "$1" ]; then
        echo "Available AWS profiles:"
        grep -E '^\[.*\]$' ~/.aws/credentials 2>/dev/null | tr -d '[]' | nl
        echo ""
        echo "Usage: aws-switch <profile_name>"
    else
        export AWS_PROFILE="$1"
        export AWS_DEFAULT_PROFILE="$1"
        echo "Switched to AWS profile: $1"
        aws sts get-caller-identity 2>/dev/null || echo "Warning: Could not verify credentials"
    fi
}

# List all cloud accounts
cloud-status() {
    echo "=== Cloud Provider Status ==="
    echo ""
    
    # AWS
    if command -v aws &>/dev/null; then
        echo "AWS:"
        aws sts get-caller-identity 2>/dev/null && echo "  ✓ Authenticated" || echo "  ✗ Not authenticated"
        echo "  Profile: ${AWS_PROFILE:-default}"
        echo ""
    fi
    
    # Azure
    if command -v az &>/dev/null; then
        echo "Azure:"
        az account show 2>/dev/null && echo "  ✓ Authenticated" || echo "  ✗ Not authenticated"
        echo ""
    fi
    
    # GCP
    if command -v gcloud &>/dev/null; then
        echo "Google Cloud:"
        gcloud config get-value account 2>/dev/null && echo "  ✓ Authenticated" || echo "  ✗ Not authenticated"
        echo "  Project: $(gcloud config get-value project 2>/dev/null)"
        echo ""
    fi
}

# Quick SSH to AWS EC2 instance
ec2-ssh() {
    if [ -z "$1" ]; then
        echo "Usage: ec2-ssh <instance-id> [user]"
        return 1
    fi
    
    local instance_id="$1"
    local user="${2:-ec2-user}"
    
    aws ec2 describe-instances --instance-ids "$instance_id" --query 'Reservations[0].Instances[0].PublicIpAddress' --output text | \
    xargs -I {} ssh "$user@{}"
}

# Get EC2 instance IP
ec2-ip() {
    if [ -z "$1" ]; then
        echo "Usage: ec2-ip <instance-id>"
        return 1
    fi
    
    aws ec2 describe-instances --instance-ids "$1" --query 'Reservations[0].Instances[0].PublicIpAddress' --output text
}