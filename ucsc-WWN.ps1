##Powercli script ot get WWNs from service profiles of UCS central.
## Biswajit 07/02/17
# gethba.ps1
# This script will generate output from UCS Central.

# Prompt user for SP information
$sp_name = read-host "Enter some word or number maching UCS profiles"

# Connect to UCS central
connect-ucscentral <UCS Central IP or FQDN >
#Please repalce vHBA template name as per your naming convention. I have used "*vHBA-A and vHBA-B"#

# Get HBA WWNs
$service_profiles = get-ucscentralserviceprofile | where-object -Property DN -like "*$sp_name*" | select Name, @{N='vHBA-A';E={get-ucscentralserviceprofile -Name $_.name | Get-UcsCentralVhba | where name -like "*vHBA-A*" | select addr -ExpandProperty addr}},
@{N='vHBA-B';E={get-ucscentralserviceprofile -Name $_.name | Get-UcsCentralVhba | where name -like "*vHBA-B*" | select addr -ExpandProperty addr}} | export-csv "c:\temp\$($sp_name)hba.csv"
