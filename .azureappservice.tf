terraform {
	required_providers {
		azure = {
			source = "hashicorp/azurerm"
		}
	}
}

provider "azure" {
	features {}
}

resource "azurerm_resource_group" "dotcv_rg" {
	name		= "dotcv_rg"
	location 	= "UK South"
}

resource "azurerm_app_service_plan" "dotcv_asp" {
	name				= "dotcv_asp"
	location			= azurerm_resource_group.dotcv_rg.location
	resource_group_name = azurerm_resource_group.dotcv_rg.name

	sku {
		tier = "Free"
		size = "F1"
	}
}

resource "azurerm_app_service" "dotcv_as" {
	name	= "dotcv_as"
	location			= azure_resource_group.dotcv_rg.location
	resource_group_name	= azurerm_resource_group.dotcv_rg.name
	app_service_plan_id	= azurerm_app_service_plan.dotcv_asp.id

	site_config {
		dotnet_framework_version	= "v6.0"
		scm_type					= "LocalGit"
	}
}
