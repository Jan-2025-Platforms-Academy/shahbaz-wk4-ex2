#!/bin/bash
ENV=$1

if [[ "$ENV" != "dev" && "$ENV" != "prod" ]]; then
  echo "Usage: $0 [dev|prod]"
  exit 1
fi

echo "Initializing Terraform for $ENV environment..."
terraform init -reconfigure -backend-config=$ENV/backend-$ENV-config.hcl

echo "Running Terraform plan for $ENV..."
terraform plan -var-file=$ENV/$ENV.tfvars

# run it with ./tf-plan.sh dev or ./tf-plan.sh prod
# This script is similar to the tf-apply.sh script, but it runs terraform apply instead of terraform apply.
# The script takes one argument, which is the environment to plan the changes for. It checks if the environment is either "dev" or "prod" and exits with an error message if it's not.
# It then initializes Terraform for the specified environment using the backend configuration file.
# Finally, it runs terraform plan with the specified environment's variables file to generate an execution plan for the changes.
# To run this script, use ./tf-plan.sh dev or ./tf-plan.sh prod, depending on the environment you want to plan the changes for.
# This script assumes that the Terraform configuration is already initialized for the specified environment.
# Note: Make sure to review the plan output before applying the changes using the tf-apply.sh script.
# For a pipeline you need chmod +x tf-plan.sh and chmod +x tf-apply.sh
