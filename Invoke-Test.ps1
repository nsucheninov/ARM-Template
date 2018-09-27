$parameters = @{ ResourceGroupName = "test03"; TemplateFile = "$Env:BUILD_SOURCESDIRECTORY\azuredeploy.json"; TemplateParameterFile = "$Env:BUILD_SOURCESDIRECTORY\azuredeploy.parameters.json" }
$script = @{ Path = "$Env:BUILD_SOURCESDIRECTORY\Template.Tests.ps1"; Parameters = $parameters }

Invoke-Pester -Script $script
