Param(
  [string] [Parameter(Mandatory=$false)] $ResourceGroupName ="test03",
  [string] [Parameter(Mandatory=$false)] $TemplateFile ="$(System.DefaultWorkingDirectory)\azuredeploy.json",
  [string] [Parameter(Mandatory=$false)] $TemplateParameterFile = "$(System.DefaultWorkingDirectory)\azuredeploy.parameters.json"
)

Describe "Template Deployment Tests" {
  BeforeAll {
    $DebugPreference = "Continue"
  }

  AfterAll {
    $DebugPreference = "SilentlyContinue"
  }

  Context "Pester module" {
    It "Passed Pester module version check" {
      $module = Get-Module -Name Pester | Where-Object Version -match "4.4.*" 5>&1
      $module | Should -Not -Be $null
    }
  }

  Context "Resource Group" {
    It "Passed Resource Group existence check" {
        $group = Get-AzureRmResourceGroup -Name $ResourceGroupName 5>&1
        $group | Should -Not -Be $null
    }
  }

  Context "When Template deployed without parameters" {
    try {
      $output = Test-AzureRmResourceGroupDeployment `
                -ResourceGroupName $ResourceGroupName `
                -TemplateFile $TemplateFile `
                -TemplateParameterFile $null `
                -ErrorAction Stop `
                 5>&1
    }
    catch {
      $ex = $_.Exception | Format-List -Force
    }

    It "Should throw exception" {
      $ex | Should -Not -Be $null
      $ex.Message | Should -Not -Be ([string]::Empty)
    }
  }

  Context "When Template deployed with parameters" {
    $output = Test-AzureRmResourceGroupDeployment `
              -ResourceGroupName $ResourceGroupName `
              -TemplateFile $TemplateFile `
              -TemplateParameterFile $TemplateParameterFile `
              -ErrorAction Stop `
               5>&1
    $result = (($output[32] -split "Body:")[1] | ConvertFrom-Json).properties

    It "Should be deployed successfully" {
      $result.provisioningState | Should -Be "Succeeded"
    }

    It "Virtual machine should have name" {
      $resource = $result.validatedResources | Where-Object type -match "virtualMachine"

      $resource.name | Should -Not -Be ([string]::Empty)
    }
  }
}