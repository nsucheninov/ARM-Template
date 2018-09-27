$cred = Get-Credential

$params = @{ adminUsername = $cred.UserName; adminPassword = $cred.Password; dnsLabelPrefix = "nsuchen01" }

$parameters = @{ ResourceGroupName = "test03"; TemplateFile = ".\azuredeploy.json"; Parameters = $params }
$script = @{ Path = ".\Template.Tests.ps1"; Parameters = $parameters }

Invoke-Pester -Script $script