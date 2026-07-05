terraform {
  cloud {
    organization = "adityatetaliorg"
    workspaces {
      name = "terraform-azure-iam-cli"
    }
  }
}
