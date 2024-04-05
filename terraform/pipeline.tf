# resource "aws_codecommit_repository" "app_frontend" {
#   repository_name = "myapp_frontend"
#   description = "myapp_frontend"
# }

resource "aws_ecr_repository" "myapp_ecr" {
  name                 = "myapp_ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


data "aws_iam_policy_document" "assume_role_codebuild" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_role_codebuild" {
  name               = "CodeBuildEKSRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_codebuild.json
}

data "aws_iam_policy_document" "iam_policy_codebuild" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ecr:*",
    ]

    resources = ["*"]
  }
  statement {
    effect = "Allow"

    actions = [
      "eks:Describe*",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "iam_policy_codebuild" {
  role   = aws_iam_role.iam_role_codebuild.name
  policy = data.aws_iam_policy_document.iam_policy_codebuild.json
}

resource "aws_codebuild_project" "example" {
  name          = "my-app-frontend-deployment"
  description   = "Codebuild for my-app-frontend-deployment"
  build_timeout = 5
  service_role  = aws_iam_role.iam_role_codebuild.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "EKS_CLUSTERNAME"
      value = var.cluster_name
    }
    environment_variable {
      name  = "REPOSITORY_URI"
      value = aws_ecr_repository.myapp_ecr.repository_url
    }
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

}
