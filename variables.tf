variable "name" {
  type = string
  default = ""
}

variable "zone" {
  type = string
  # "test.ru."
}

variable "vpc_ids" {
}

variable "public" {
  type = bool
  default = false
}

variable "records" {
  default = []
  #{ name = "dev.", type = "CNAME", data = ["ya.ru"] },
}