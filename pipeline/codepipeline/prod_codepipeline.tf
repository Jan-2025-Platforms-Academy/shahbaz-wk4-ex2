resource "aws_codepipeline" "prod_codepipeline" {
  name     = "shahbaz-prod-codepipeline"
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
    name = "prod_plan"

    action {
      name            = "prod_plan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["source_output"]
      output_artifacts = ["plan_prod_output"]
      configuration = {
        ProjectName = var.prod_project_name
      }
    }
  }

  stage {
    name = "prod_approval"

    action {
      name            = "prod_approval"
      category        = "Approval"
      owner           = "AWS"
      provider        = "Manual"
      version         = "1"
      configuration = {
        CustomData = "Approve the change to deploy to prod"
      }
    }
  }

  stage {
    name = "prod_apply"

    action {
      name            = "prod_apply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["plan_prod_output"]
      configuration = {
        ProjectName = var.prod_project_name
      }
    }
  }
  
}