#!/bin/bash
ENV=$1

if [[ "$ENV" != "dev" && "$ENV" != "prod" ]]; then
  echo "Usage: $0 [dev|prod]"
  exit 1
fi

echo "Applying Terraform changes for $ENV..."
terraform apply -var-file=$ENV/$ENV.tfvars

# run it with ./tf-apply.sh dev or ./tf-apply.sh prod
# This script is similar to the tf-plan.sh script, but it runs terraform apply instead of terraform plan.
# The script takes one argument, which is the environment to apply the changes to. It checks if the environment is either "dev" or "prod" and exits with an error message if it's not.
# It then applies the Terraform changes using the specified environment's variables file.
# To run this script, use ./tf-apply.sh dev or ./tf-apply.sh prod, depending on the environment you want to apply the changes to.
# This script assumes that the Terraform configuration is already initialized and planned for the specified environment.
# Note: Make sure to run the tf-plan.sh script before running this script to ensure that the changes are planned and reviewed before applying them.
# For a pipeline you need chmod +x tf-plan.sh and chmod +x tf-apply.sh
