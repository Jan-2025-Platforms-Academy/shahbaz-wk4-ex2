resource "aws_codepipeline" "this" {
  name     = "shahbaz-project-codepipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = "shahbaz-eu-west-1-build-artifact" # hardcoded will use var later
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = "https://github.com/Jan-2025-Platforms-Academy/shahbaz-wk4-ex2" # hardcoded will use var later
        BranchName     = "main" # hardcoded will use var later
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
        ProjectName = aws_codebuild_project.dev.name
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
    name = "dev_apply"

    action {
      name            = "dev_apply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["plan_dev_output"]
      configuration = {
        ProjectName = aws_codebuild_project.dev.name
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
        ProjectName = aws_codebuild_project.prod.name
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
        ProjectName = aws_codebuild_project.prod.name
      }
    }
  }

}