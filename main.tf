terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "~> 2.23.1"
    }
  }
}

variable VULTR_API_KEY { } //From env
provider "vultr" {
  api_key = "${var.VULTR_API_KEY}"
}





locals {
  public_key = ""
}

module "vultr1"{
  source = "./vultr_instance"
  instance_settings = {
    plan = "vc2-1c-1gb"
    region = "waw"
    os_id = 1743
    label = "label"
  }
  public_key = {
    name = "random_vultr_key"
    pubkey = local.public_key
  }
}

output "main_ip" {
  value = module.vultr1.main_ip
}