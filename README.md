# ProjectGenie

![logo](https://raw.githubusercontent.com/Nochisoft/ProjectGene/master/projectgenie.png)


### Overview

This project is to illustrate how GitHub can be used for the administration of GitHub e.g. to create projects, to create repositories, to enables access to Azure, etc.
As an Initial ideation, ProjectGene is to realize how to create a Project with a repo and an associated Azure environment with One Click. It also automates the deletion of a project and its associated resources, like repos & azure resources. This can be extended as a Virtual Assistant for GitHub Administrators which can manage project operations with utmost standardization and best practices. 


### Current features

As an initial version, ProjectGene is capable of 
  * Create GitHub Repository for Collaboration with standard repo structure
  * Create Project Boards with Cards & Boards for standard Agile process
  * Provides access to Azure with approved budget with flexibility to deploy any resource to Azure 
  * Configures GitHub Secrets as AZURE_CREDENTIALS for Continuous Deployment using GitHub Actions/Workflows

### How to Use

#### Prerequisites

  * Github Access as Organisation administrator 
  * Gihub Access Token at Organization scope
  * Azure Subscription 
  * Azure AD SPN with following permissions:
      * Owner role at Azure subscription scope
      * API Permissions on Azure AD: Azure Active Directory Graph ->Application.ReadWrite.OwnedBy (Manage apps that this app creates or owns)
      
#### Initial Setup & Configuration
  1. Configure ProjectGene:
       * Create a Project under GitHub Organization 
       * Create a Project Access Token and update org level Secret with name ACTION_PAT
       * Create GitHub Secret with name AZURE_CREDENTIALS in the format below filled with details of SPN
   ```   
       {
        "subscriptionId": <Azure-subscriptionId>,
        "tenantId": <tenantId>,
        "clientId": "<appId>",
        "clientSecret": "<password>",
        "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
        "resourceManagerEndpointUrl": "https://management.azure.com/",
        "activeDirectoryGraphResourceId": "https://graph.windows.net/",
        "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
        "galleryEndpointUrl": "https://gallery.azure.com/",
        "managementEndpointUrl": "https://management.core.windows.net/"
        }
   ```
 2. Import this repo i.e. projectGene repo into your GitHub project
 3. Run the github workflow projectgene_setup.yaml which does the following
  ```
        * Creates Project Boards with  'To do', 'In Progress' and 'Created' columns
        * Creates a template Repository under the organization with the required structure
        * Creates Azure resourcegroup with a specific Azur region as default region 
        * Creates Azure Keyvault and sets access policies to store project secrets to access azure
  ```
  #### Create a new Project
  * Create an issue in the project 
  * move the issue across the columns in Boards
  * When the issue moves to "In Progress" column, the Github workflow to create a new project starts and updates the result
 







