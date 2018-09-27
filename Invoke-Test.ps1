$parameters = @{ ResourceGroupName = "test03"; TemplateFile = "$Env:BUILD_SOURCESDIRECTORY\azuredeploy.json"; TemplateParameterFile = "$Env:BUILD_SOURCESDIRECTORY\azuredeploy.parameters.json" }
$script = @{ Path = "$Env:BUILD_SOURCESDIRECTORY\Template.Tests.ps1"; Parameters = $parameters }

$outputFile = "$ENV:COMMON_TESTRESULTSDIRECTORY\TEST-testFile-$ENV:BUILD_BUILDNUMBER.xml"

Write-Host $outputFile

Invoke-Pester -Script $script -OutputFile $outputFile
