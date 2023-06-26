locals {
  vpc_ids = try(jsondecode(var.vpc_ids), var.vpc_ids)
  records = {
    for k,v in try(jsondecode(var.records), var.records) :
      replace("${v.name}|${v.type}","/[@.]/","!") => v
  }
}

resource "yandex_dns_zone" "zone" {
  name   = var.name
  zone   = var.zone
  public = var.public
  private_networks = local.vpc_ids
}

resource "yandex_dns_recordset" "records" {
  for_each = local.records
  zone_id  = yandex_dns_zone.zone.id
  name     = "${replace(each.value.name, "@", "")}${var.zone}"
  type     = each.value.type
  ttl      = lookup(each.value, "ttl", 600)
  data     = each.value.data
}
