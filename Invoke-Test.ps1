#$parameters = @{ ResourceGroupName = "test03"; TemplateFile = "$(System.DefaultWorkingDirectory)\azuredeploy.json"; TemplateParameterFile = "$(System.DefaultWorkingDirectory)\azuredeploy.parameters.json" }
#$script = @{ Path = "$(System.DefaultWorkingDirectory)\Template.Tests.ps1"; Parameters = $parameters }

Write-Host "Test:"
Write-Host $(system.teamProject)
Write-Host "----------------------------------"
Write-Host $(system.DefaultWorkingDirectory)
Write-Host "----------------------------------"

#Invoke-Pester -Script $script
