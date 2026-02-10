$jsonText = @($input) -join "`n"
try {
    $data = $jsonText | ConvertFrom-Json
    $model = $data.model.display_name
    $pct = $data.context_window.used_percentage
    $context = if ($pct) { "$([math]::Round(100 - $pct))%" } else { "--%" }
    $userHome = $env:USERPROFILE
    $cwd = if ($data.cwd) { $data.cwd } else { Get-Location }
    $rel = if ($userHome -and $cwd.ToString().StartsWith($userHome)) {
        '~' + $cwd.ToString().Substring($userHome.Length).Replace('\', '/')
    } else { $cwd }
    Write-Output "$model | ${context} remaining | $rel"
} catch {
    Write-Output "ERR: $($_.Exception.Message) | INPUT: $jsonText"
}
