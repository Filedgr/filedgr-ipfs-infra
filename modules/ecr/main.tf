resource "aws_ecr_repository" "filedgr-ipfs-repo" {
  name = "filedgr-ipfs"
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "KMS"
    kms_key = var.ecr_kms_key
  }

  image_scanning_configuration {
    scan_on_push = true
  }
}