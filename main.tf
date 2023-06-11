terraform {
	required_providers {
		azurerm = {
			source = "hashicorp/azurerm"
		}
	}
}

provider "azurerm" {
	features {}
}

resource "azurerm_resource_group" "dotcv-rg" {
	name		= "dotcv-rg"
	location 	= "UK South"
}

resource "azurerm_app_service_plan" "dotcv-sp" {
	name				= "dotcv-asp"
	location			= azurerm_resource_group.dotcv-rg.location
	resource_group_name = azurerm_resource_group.dotcv-rg.name
	kind				= "Linux"
	reserved			= true

	sku {
		tier = "Free"
		size = "F1"
	}
}

resource "azurerm_linux_web_app" "dotcv-as" {
	name	= "dotcv-as"
	location			= azurerm_resource_group.dotcv-rg.location
	resource_group_name	= azurerm_resource_group.dotcv-rg.name
	service_plan_id		= azurerm_app_service_plan.dotcv-sp.id

	site_config {
		always_on = "false"
		application_stack {
			docker_image = "lewissenior/dotcv"
			docker_image_tag = "latest"
		}
	}
}
