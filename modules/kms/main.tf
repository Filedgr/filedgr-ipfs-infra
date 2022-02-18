data "aws_caller_identity" "current" {}

locals {
    account_id = data.aws_caller_identity.current.account_id
}

resource "aws_kms_key" "filedgr-ipfs-key" {
  description             = "Key used for the IPFS gateway"
  deletion_window_in_days = 10

#  policy = jsonencode(data.aws_iam_policy_document.kms_key_policy)
  policy = data.aws_iam_policy_document.kms_key_policy.json
}

resource "aws_kms_alias" "kms_kay_alias" {
  name = "alias/filedgr-ipfs-ecr-kms"
  target_key_id = aws_kms_key.filedgr-ipfs-key.id
}

data "aws_iam_policy_document" "kms_key_policy" {
  statement {
    sid       = "Enable IAM User permissions"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      identifiers = ["arn:aws:iam::${local.account_id}:root"]
      type        = "AWS"
    }
  }

  statement {
    sid     = "Enable usage for services"
    effect  = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:DescribeKey"
    ]
    resources = ["*"]

    principals {
      identifiers = ["*"]
      type        = "*"
    }
    condition {
      test     = "StringEquals"
      values   = ["ecr.eu-central-1.amazonaws.com"]
      variable = "kms:ViaService"
    }
  }

}