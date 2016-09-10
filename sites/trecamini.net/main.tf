variable "region" {
  description = "Region specified by the root module"
  type = "string"
}

provider "aws" {
  alias  = "private"
  region = "${var.region}"
}
