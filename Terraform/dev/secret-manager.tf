resource "aws_secretsmanager_secret" "pdems_secret" {
  name        = "pdems-dev_secret"
  description = "dev PDems secret"

  tags = {
    AirbyteManaged = "true"
  }
}

# resource "aws_secretsmanager_secret_version" "pdems_secret_version" {
#   secret_id     = aws_secretsmanager_secret.pdems_secret.id
#   secret_string = jsonencode({
#     username = var.db_username
#     password = var.db_password
#   })
# }

resource "aws_iam_policy" "secrets_manager_policy" {
  name        = "PDEMSSecretsManagerPolicy"
  description = "Policy to manage secrets in Secrets Manager"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:CreateSecret",
          "secretsmanager:ListSecrets",
          "secretsmanager:DescribeSecret",
          "secretsmanager:TagResource",
          "secretsmanager:UpdateSecret"
        ]
        Resource = "*"
        Condition = {
          "ForAllValues:StringEquals" = {
            "secretsmanager:ResourceTag/AirbyteManaged" = "true"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role" "secrets_manager_role" {
  name = "PDEMSSecretsManagerRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"  
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secrets_manager_policy" {
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
  role       = aws_iam_role.secrets_manager_role.name
}
