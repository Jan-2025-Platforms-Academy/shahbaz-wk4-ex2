resource "aws_codepipeline" "dev_codepipeline" {
  name     = "shahbaz-dev-codepipeline"
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = var.artifact_bucket_name
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

        configuration = {
        Owner = var.github_owner
        Repo = var.github_repo
        Branch     = var.github_branch
        OAuthToken = var.github_token
      }
    }
  }

  stage {
    name = "dev_plan"

    action {
      name            = "dev_plan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["source_output"]
      output_artifacts = ["plan_dev_output"]
      configuration = {
        ProjectName = var.dev_project_name
      }
    }
  }
  stage {
    name = "dev_approval"

    action {
      name            = "dev_approval"
      category        = "Approval"
      owner           = "AWS"
      provider        = "Manual"
      version         = "1"
      configuration = {
        CustomData = "Approve the change to deploy to dev"
      }
    }
  }
  stage {
        name = "dev_deploy"
    
        action {
        name            = "dev_deploy"
        category        = "Build"
        owner           = "AWS"
        provider        = "CodeBuild"
        version         = "1"
        input_artifacts = ["plan_dev_output"]
        configuration = {
            ProjectName = var.dev_project_name
        }
       }
    }
}
