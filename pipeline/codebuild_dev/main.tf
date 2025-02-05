resource "aws_codebuild_project" "dev" {
    name = "shahbaz-dev-plan"
    service_role = var.codebuild_role_arn
    source {
      type = "GITHUB"
      location = "https://github.com/Jan-2025-Platforms-Academy/shahbaz-wk4-ex2"
      buildspec = "../buildspec.yml"
    }
    environment {
        compute_type = "BUILD_GENERAL1_SMALL"
        image = "aws/codebuild/standard:4.0"
        type = "LINUX_CONTAINER"
        environment_variable {
            name = "TF_ACTION"
            value = "plan"
        }
        environment_variable {
            name = "ENVIRONMENT"
            value = "dev"
        }
    }
    artifacts {
        type = "NO_ARTIFACTS"
    }  
}

output "dev_project_name" {
  value = aws_codebuild_project.dev.name
}
