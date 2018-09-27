$parameters = @{ ResourceGroupName = "test03"; TemplateFile = ".\azuredeploy.json"; TemplateParameterFile = ".\azuredeploy.parameters.json" }
$script = @{ Path = ".\Template.Tests.ps1"; Parameters = $parameters }

Get-Location
Get-ChildItem

Invoke-Pester -Script $script