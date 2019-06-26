# this creates and configures a front door resource using an 
# ARM template
#
echo "create Front Door: $IAC_EXCLUSIVE_FRONTDOORNAME"
az group deployment create --name azuredeployfd --resource-group $IAC_EXCLUSIVE_RESOURCEGROUPNAME --template-file "$AGENT_RELEASEDIRECTORY/AbelIaCBuild/drop/frontdoorazuredeploy.json" --parameters frontDoorName=$IAC_EXCLUSIVE_FRONTDOORNAME backendPool1Address1="$IAC_EXCLUSIVE_WEBSTORAGEACCOUNTNAME.z21.web.core.windows.net" backendPool2Address1="$IAC_EXCLUSIVE_FUNCTIONNAME.azurewebsites.net" customDomainName="$IAC_DNSNAME"
echo ""

# this addes the front door extension to the azure cli. It's currently in preview
# hopefully i can remove this soon
#
az extension add \
    --name front-door

# this enables https for the custom domain front end host
#
echo "enabling https for front end host $IAC_FRIENDLYDNSNAME"
az network front-door frontend-endpoint enable-https \
    --front-door-name $IAC_EXCLUSIVE_FRONTDOORNAME \
    --name $IAC_FRIENDLYDNSNAME \
    --resource-group $IAC_EXCLUSIVE_RESOURCEGROUPNAME
echo ""