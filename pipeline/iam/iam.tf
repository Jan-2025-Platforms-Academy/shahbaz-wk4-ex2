
# Codebuild IAM roles and policies

resource "aws_iam_role" "codebuild_role" {
  name = "shahbaz-codebuild-role"
    assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "codebuild.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
    }
    EOF 
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
  
}

resource "aws_iam_role_policy" "codebuild_s3_policy" {
  name = "codebuild-s3-policy"
  role = aws_iam_role.codebuild_role.id

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:PutObjectAcl"
        ],
        "Resource": "arn:aws:s3:::shahbaz-eu-west-1-build-artifact/shahbaz-dev-codepipe/source_out/*"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "codebuild_logs_policy" {
  name = "codebuild-logs-policy"
  role = aws_iam_role.codebuild_role.id

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:eu-west-1:841162714039:log-group:/aws/codebuild/shahbaz-dev-deploy:*"
      }
    ]
  }
  EOF
}

# Codepipeline IAM roles and policies

resource "aws_iam_role" "codepipeline_role" {
  name = "shahbaz-codepipeline-role"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "codepipeline.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
    EOF
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
  
}

resource "aws_iam_role_policy" "codepipeline_s3_policy" {
  name = "codepipeline-s3-policy"
  role = aws_iam_role.codepipeline_role.id

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::shahbaz-eu-west-1-build-artifact/*"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "codepipeline_codebuild_policy" {
  name = "codepipeline-codebuild-policy"
  role = aws_iam_role.codepipeline_role.id

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "codebuild:StartBuild",
        "Resource": "arn:aws:codebuild:eu-west-1:841162714039:project/shahbaz-dev-deploy"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "codepipeline_codebuild_batchgetbuilds_policy" {
  name = "codepipeline-codebuild-batchgetbuilds-policy"
  role = aws_iam_role.codepipeline_role.id

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "codebuild:BatchGetBuilds",
        "Resource": "arn:aws:codebuild:eu-west-1:841162714039:project/shahbaz-dev-deploy"
      }
    ]
  }
  EOF
}




# Output

output "codebuild_role_arn" {
  value = aws_iam_role.codebuild_role.arn
}

output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline_role.arn
}
