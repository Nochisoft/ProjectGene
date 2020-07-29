## takes the spn filename as input 

spnjson=$1

tenantId=$(echo "$spnjson" | jq '.tenantId')
appId=$(echo "$spnjson" | jq '.appId')
password=$(echo "$spnjson" | jq '.password')

# login to Azure using the SPN credentials and get the azure subscription details

az login --service-principal  -u "<appId>"  -p "<password>"  --tenant  "<tenantId>" --verbose
subjson=$(az account show)
subscriptionId=$(echo "$subjson" | jq '.id')

#create the github_secret.json file with azure spn credentials

echo "{" > github_secret.json
echo  "\"subscriptionId\": \"$subscriptionId\", " >> github_secret.json
echo  "\"tenantId\": \"$tenantId\" ,">> github_secret.json
echo  "\"clientId\": \"$appId\" ," >> github_secret.json
echo  "\"clientSecret\": \"$password\"," >> github_secret.json
echo  "\"activeDirectoryEndpointUrl\": \"https://login.microsoftonline.com\",">> github_secret.json
echo  "\"resourceManagerEndpointUrl\": \"https://management.azure.com/\"," >> github_secret.json
echo  "\"activeDirectoryGraphResourceId\": \"https://graph.windows.net/\",">> github_secret.json
echo  "\"sqlManagementEndpointUrl\": \"https://management.core.windows.net:8443/\"," >> github_secret.json
echo  "\"galleryEndpointUrl\": \"https://gallery.azure.com/\"," >> github_secret.json
echo  "\"managementEndpointUrl\": \"https://management.core.windows.net/\" " >> github_secret.json
echo "}">> github_secret.json
#create azure Keyvault for storing spn details and also the SPNs created by projectGene
az group create  --name projectgene-rg --location southeastasia
az keyvault create --name projectgene-kv  --locaiton southeastasia --resource-group projectgene-rg 
az keyvault set-policy --name projectgene-kv --object-id appId --key-permissions "create delete get purge update"
