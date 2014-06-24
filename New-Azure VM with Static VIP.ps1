#==========================================================================
#
# NAME: Create New Azure VM using existing Reserved VIP
#
# AUTHOR: Andreas Wasita
# DATE  : 24/06/2014
#
# COMMENT: 
# 
# VERSION: 0.1
#
# REVISION HISTORY:
# <date>		<sign>		<comments>
#
# 24/06/2014	 AW          Draft
#
#==========================================================================

cls

Import-module Azure

$subscription = Read-Host -Prompt 'Microsoft Azure Subscription:'
$storage = Read-Host -Prompt 'Storage Account Name:'

Set-azuresubscription -SubscriptionName $subscription -CurrentStorageAccountName $storage

#Get the latest Windows Server 2012 Datacenter image
$images = Get-AzureVMImage `
| where { $_.ImageFamily -eq “Windows Server 2012 Datacenter” } `
| Sort-Object -Descending -Property PublishedDate
 
$latestImage = $images[0]
$latestImage

$myimage = Read-Host -Prompt 'Azure Image Name:'
$service = Read-Host -Prompt 'Azure Service Name:'
$name = Read-Host -Prompt 'Azure VM Name:'
$instance = Read-Host -Prompt 'Instance Size:'
$username = Read-Host -Prompt 'Admin User Name:'
$password = Read-Host -Prompt 'Password:'
$VIP = Read-Host -Prompt 'Reserved VIP Name:'
$location = Read-Host -Prompt 'Azure Location:'

$myVM = New-AzureVMConfig -Name $name -InstanceSize $instance -ImageName $myimage -DiskLabel "OS" `
| Add-AzureProvisioningConfig -Windows -Password $password -AdminUsername $username -DisableAutomaticUpdates

New-AzureVM -ServiceName $service -VMs $myVM -ReservedIPName $VIP -Location $location