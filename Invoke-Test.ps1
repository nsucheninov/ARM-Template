$parameters = @{ ResourceGroupName = "test03"; TemplateFile = "$(System.DefaultWorkingDirectory)\azuredeploy.json"; TemplateParameterFile = "$(System.DefaultWorkingDirectory)\azuredeploy.parameters.json" }
$script = @{ Path = "$(System.DefaultWorkingDirectory)\Template.Tests.ps1"; Parameters = $parameters }

Get-Location
Get-ChildItem

Invoke-Pester -Script $script
