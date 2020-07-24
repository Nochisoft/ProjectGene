#Script to update the SPN file with azure spn credentials
#uses the file passed as the parameter
subscriptionId=`az account show --query id`
tenantId=`az account show --query tenantId`
temp=`cat $1`
appId=`echo $temp | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["appId"]'`
password=`echo $temp | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["password"]'`
## Copy the template file and update it with the SPN credentials
cp $GITHUB_WORKSPACE/src/azure-access-template.json github-secret.json
sed -i -e "s/<subscriptionId>/$subscriptionId/g" github-secret.json
sed -i -e "s/<tenantId>/$tenantId/g" github-secret.json
sed -i -e "s/<clientId>/$appId/g" github-secret.json
sed -i -e "s/<password>/$password/g" github-secret.json

