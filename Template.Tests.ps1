Param(
  [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
  [string] [Parameter(Mandatory=$true)] $TemplateFile,
  [hashtable] [Parameter(Mandatory=$true)] $Parameters
)

Describe "Template Deployment Tests" {
  BeforeAll {
    $DebugPreference = "Continue"
  }

  AfterAll {
    $DebugPreference = "SilentlyContinue"
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
                -adminUsername $null `
                -adminPassword $null `
                -dnsLabelPrefix $null `
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
              -TemplateParameterObject $Parameters `
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