resource "aws_codecommit_repository" "app_frontend" {
  repository_name = "myapp_frontend"
  description = "myapp_frontend"
}

resource "aws_ecr_repository" "myapp_ecr" {
  name                 = "myapp_ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
/*
data "template_file" "buildspec_ysuite_app_dev" {
  template = file("${path.module}/files/codebuild_buildspec.yml")
}

data "aws_iam_policy" "AWSCodeBuildRolePolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSCodeBuildRole"  
}

resource "aws_iam_role" "CodeBuildServiceRole" {
  name                = "CodeBuildEKSRole"  
  #managed_policy_arns = [data.aws_iam_policy.AWSCodeBuildRolePolicy.arn]
   assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          "Service": "codebuild.amazonaws.com"
        }
      },
    ]
   })
}

resource "aws_codebuild_project" "codebuild_ysuite_app_dev" {  
  name = "myapp_frontend_release_pipeline"
  description = "Codebuild Project to release frontend application"
  build_timeout = "60"
  service_role = aws_iam_role.CodeBuildServiceRole.arn  
  artifacts {
    type  = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name = "EKS_CLUSTERNAME"
      value = var.cluster_name
    }

    environment_variable {
      name = "EKS_ROLE_ARN"
      value = aws_iam_role.CodeBuildServiceRole.arn
    }

    environment_variable {
      name = "REPOSITORY_URL"
      value = aws_ecr_repository.myapp_ecr.repository_url
    }
  }

  logs_config {
    cloudwatch_logs {
      status  = "ENABLED"
    }
  }

  source {
    type  = "NO_SOURCE"
  }


  tags = {
    "MANAGED_BY" = "terraform"
  }

}

*/