[cmdletbinding()]
param(
)

Function Invoke-ScriptBlock {
    param(
        [System.Management.Automation.ScriptBlock]
        $Command
    )
    Write-Host -ForegroundColor Cyan $Command
    $Command.Invoke()
}

$folder = "$PSScriptRoot/klipper"
Invoke-ScriptBlock { Remove-Item -Recurse -Force "$folder/*" }
Invoke-ScriptBlock { scp biqu@trident:printer_data/config/* "$folder" }
Invoke-ScriptBlock { git add "$folder"; git clean -fdx "$folder" }
Invoke-ScriptBlock { Get-ChildItem "$folder/*" | Select-String "token|key|passwor[dt]" }

