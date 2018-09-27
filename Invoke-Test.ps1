#$parameters = @{ ResourceGroupName = "test03"; TemplateFile = "$(System.DefaultWorkingDirectory)\azuredeploy.json"; TemplateParameterFile = "$(System.DefaultWorkingDirectory)\azuredeploy.parameters.json" }
#$script = @{ Path = "$(System.DefaultWorkingDirectory)\Template.Tests.ps1"; Parameters = $parameters }

Write-Host "Test:"
Write-Host "----------------------------------"
Get-Module -Name Pester
Write-Host "----------------------------------"
Write-Host "source directory = $Env:BUILD_SOURCESDIRECTORY"
Write-Host "----------------------------------"
Get-Content "$Env:BUILD_SOURCESDIRECTORY\azuredeploy.parameters.json"
Write-Host "----------------------------------"


#Invoke-Pester -Script $script
