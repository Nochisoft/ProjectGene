## takes the spn filename as input 

spnjson=$1

tenantId=$(echo "$spnjson" | jq '.tenantId')
appId=$(echo "$spnjson" | jq '.appId')
password=$(echo "$spnjson" | jq '.password')

# login to Azure using the SPN credentials and get the azure subscription details

az login --service-principal  -u "<appId>"  -p "<password>"  --tenant  "<tenantId>" --verbose
subjson=$(az account show)
subscriptionId=$(echo "$subjson" | jq '.id')

#create azure Keyvault for storing spn details and also the SPNs created by projectGene
az group create  --name projectgene-rg --location southeastasia
az keyvault create --name projectgene-kv  --locaiton southeastasia --resource-group projectgene-rg 
az keyvault set-policy --name projectgene-kv --object-id appId --key-permissions "set delete get list purge update"  
