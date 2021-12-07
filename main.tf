resource "azurerm_resource_group" "demo" {
  name     = "demo-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "demo" {
  name                = "demo-network"
  address_space       = ["192.168.168.0/24"]
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
}

resource "azurerm_subnet" "demo" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.demo.name
  virtual_network_name = azurerm_virtual_network.demo.name
  address_prefixes     = ["192.168.168.0/24"]
}

resource "azurerm_network_interface" "demo" {
  name                = "demo-nic"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.demo.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.demo.id
  }
}

resource "azurerm_linux_virtual_machine" "demo" {
  name                = "demo-machine"
  resource_group_name = azurerm_resource_group.demo.name
  location            = azurerm_resource_group.demo.location
  size                = "Standard_B1s"
  admin_username      = "student"
  network_interface_ids = [
    azurerm_network_interface.demo.id,
  ]

  admin_ssh_key {
    username   = "student"
    public_key = file("id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy-daily"
    sku       = "22_04-daily-lts"
    version   = "22.04.202112060"
  }
}

resource "azurerm_public_ip" "demo" {
  name                = "demoTerraformPublicIP"
  resource_group_name = azurerm_resource_group.demo.name
  location            = azurerm_resource_group.demo.location
  allocation_method   = "Dynamic"
}

data "azurerm_public_ip" "demo" {
  name                = azurerm_public_ip.demo.name
  resource_group_name = azurerm_resource_group.demo.name
}

output "ip" {
  value = data.azurerm_public_ip.demo.ip_address
}
