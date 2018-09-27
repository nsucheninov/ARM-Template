#$parameters = @{ ResourceGroupName = "test03"; TemplateFile = "$(System.DefaultWorkingDirectory)\azuredeploy.json"; TemplateParameterFile = "$(System.DefaultWorkingDirectory)\azuredeploy.parameters.json" }
#$script = @{ Path = "$(System.DefaultWorkingDirectory)\Template.Tests.ps1"; Parameters = $parameters }

Get-Location
Get-ChildItem

Write-Host "Test:"
Write-Host $System.DefaultWorkingDirectory
Write-Host $system.teamProject

#Invoke-Pester -Script $script
