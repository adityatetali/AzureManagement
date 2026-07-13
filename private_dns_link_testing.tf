# Existing hub VNets (data sources — adjust to your actual hub RG/names)
data "azurerm_virtual_network" "hub_centralus" {
  name                = "hub-vnet-centralus"
  resource_group_name = "rg-hub-centralus"
}

data "azurerm_virtual_network" "hub_eastus2" {
  name                = "hub-vnet-eastus2"
  resource_group_name = "rg-hub-eastus2"
}

module "private_dns_blob" {
  source  = "app.terraform.io/adityatetaliorg/dns_links/azure"

  dns_zone_name        = "privatelink.blob.core.windows.net"
  resource_group_name  = "rg-private-dns"

  central_us_vnet_id   = data.azurerm_virtual_network.hub_centralus.id
  central_us_vnet_name = data.azurerm_virtual_network.hub_centralus.name

  eastus2_vnet_id      = data.azurerm_virtual_network.hub_eastus2.id
  eastus2_vnet_name    = data.azurerm_virtual_network.hub_eastus2.name

  registration_enabled = false

  tags = {
    environment = "prod"
    managed_by  = "terraform"
  }
}

# Example: multiple private DNS zones for different services, each linked to both hub VNets
module "private_dns_zones" {
  source  = "app.terraform.io/adityatetaliorg/dns_links/azure"
  for_each = toset([
    "privatelink.database.windows.net",
    "privatelink.vaultcore.azure.net",
    "privatelink.file.core.windows.net",
  ])

  dns_zone_name        = each.value
  resource_group_name  = "rg-private-dns"

  central_us_vnet_id   = data.azurerm_virtual_network.hub_centralus.id
  central_us_vnet_name = data.azurerm_virtual_network.hub_centralus.name

  eastus2_vnet_id      = data.azurerm_virtual_network.hub_eastus2.id
  eastus2_vnet_name    = data.azurerm_virtual_network.hub_eastus2.name

  tags = {
    environment = "prod"
    managed_by  = "terraform"
  }
}