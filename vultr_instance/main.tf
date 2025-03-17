terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "~>2.23.1"
    }
  }
}

variable "public_key" {
  type = object({
    name = string
    pubkey = string
  })
}

variable "instance_settings" {
  type = object({
    plan = string
    region = string
    os_id = number
    label = string
  })
}

resource "vultr_ssh_key" "my_ssh_key" {
  name = var.public_key.name
  ssh_key = var.public_key.pubkey
}

resource "vultr_instance" "host" {
  plan = var.instance_settings.plan
  region = var.instance_settings.region
  os_id = var.instance_settings.os_id
  label = var.instance_settings.label
  ssh_key_ids = [
    vultr_ssh_key.my_ssh_key.id
  ]
}

output "main_ip" {
  sensitive = true
  value = vultr_instance.host.main_ip
}