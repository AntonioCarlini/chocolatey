

# Make file extensions visible in Explorer
$explorer_advanced_key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'

New-Item -Path $explorer_advanced_key -Force | Out-Null

New-ItemProperty `
    -Path $explorer_advanced_key `
    -Name 'HideFileExt' `
    -PropertyType DWord `
    -Value 0 `
    -Force | Out-Null
	
# Show hidden files and folders
$explorer_advanced_key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'

New-Item -Path $explorer_advanced_key -Force | Out-Null

New-ItemProperty `
    -Path $explorer_advanced_key `
    -Name 'Hidden' `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null


# Show protected operating system files
New-ItemProperty `
    -Path $explorer_advanced_key `
    -Name 'ShowSuperHidden' `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null
	
# Turn off News and interests for the current user
$feeds_key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds'

New-Item -Path $feeds_key -Force | Out-Null

New-ItemProperty `
    -Path $feeds_key `
    -Name 'ShellFeedsTaskbarViewMode' `
    -PropertyType DWord `
    -Value 2 `
    -Force | Out-Null

# Disable Start menu recommendations and promotions

$content_delivery_key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'

New-Item -Path $content_delivery_key -Force | Out-Null

$disabled_content_settings = @(
    'SystemPaneSuggestionsEnabled'
    'SubscribedContent-338388Enabled'
    'SilentInstalledAppsEnabled'
)

foreach ($setting in $disabled_content_settings) {
    New-ItemProperty `
        -Path $content_delivery_key `
        -Name $setting `
        -PropertyType DWord `
        -Value 0 `
        -Force | Out-Null
}


# Disable suggestions and promotional content in Settings

$disabled_content_settings = @(
    'SubscribedContent-338393Enabled'
    'SubscribedContent-353694Enabled'
    'SubscribedContent-353696Enabled'
)

foreach ($setting in $disabled_content_settings) {
    New-ItemProperty `
        -Path $content_delivery_key `
        -Name $setting `
        -PropertyType DWord `
        -Value 0 `
        -Force | Out-Null
}


# Disable lock-screen tips and Windows Spotlight promotional content

$disabled_content_settings = @(
    'RotatingLockScreenEnabled'
    'RotatingLockScreenOverlayEnabled'
    'SubscribedContent-338387Enabled'
    'SoftLandingEnabled'
)

foreach ($setting in $disabled_content_settings) {
    New-ItemProperty `
        -Path $content_delivery_key `
        -Name $setting `
        -PropertyType DWord `
        -Value 0 `
        -Force | Out-Null
}


# Disable Windows welcome experiences and tips

$disabled_content_settings = @(
    'SubscribedContent-310093Enabled'
    'SubscribedContent-338389Enabled'
)

foreach ($setting in $disabled_content_settings) {
    New-ItemProperty `
        -Path $content_delivery_key `
        -Name $setting `
        -PropertyType DWord `
        -Value 0 `
        -Force | Out-Null
}


# Disable File Explorer promotional notifications

$explorer_advanced_key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'

New-Item -Path $explorer_advanced_key -Force | Out-Null

New-ItemProperty `
    -Path $explorer_advanced_key `
    -Name 'ShowSyncProviderNotifications' `
    -PropertyType DWord `
    -Value 0 `
    -Force | Out-Null


# Disable search highlights

$search_settings_key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings'

New-Item -Path $search_settings_key -Force | Out-Null

New-ItemProperty `
    -Path $search_settings_key `
    -Name 'IsDynamicSearchBoxEnabled' `
    -PropertyType DWord `
    -Value 0 `
    -Force | Out-Null

# Minimise Windows diagnostic data collection

$diagnostics_key = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'

New-Item -Path $diagnostics_key -Force | Out-Null

New-ItemProperty `
    -Path $diagnostics_key `
    -Name 'AllowTelemetry' `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null


# Disable tailored experiences based on diagnostic data

$cloud_content_policy_key = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'

New-Item -Path $cloud_content_policy_key -Force | Out-Null

New-ItemProperty `
    -Path $cloud_content_policy_key `
    -Name 'DisableWindowsConsumerFeatures' `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null

$user_cloud_content_policy_key = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'

New-Item -Path $user_cloud_content_policy_key -Force | Out-Null

New-ItemProperty `
    -Path $user_cloud_content_policy_key `
    -Name 'DisableTailoredExperiencesWithDiagnosticData' `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null


# Disable the advertising ID

$advertising_info_key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo'
$advertising_policy_key = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo'

New-Item -Path $advertising_info_key -Force | Out-Null
New-Item -Path $advertising_policy_key -Force | Out-Null

New-ItemProperty `
    -Path $advertising_info_key `
    -Name 'Enabled' `
    -PropertyType DWord `
    -Value 0 `
    -Force | Out-Null

New-ItemProperty `
    -Path $advertising_policy_key `
    -Name 'DisabledByGroupPolicy' `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null


# Disable inking and typing personalisation

$input_personalisation_key = 'HKCU:\Software\Microsoft\InputPersonalization'

New-Item -Path $input_personalisation_key -Force | Out-Null

New-ItemProperty `
    -Path $input_personalisation_key `
    -Name 'RestrictImplicitTextCollection' `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null

New-ItemProperty `
    -Path $input_personalisation_key `
    -Name 'RestrictImplicitInkCollection' `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null


# Disable online speech recognition

$speech_policy_key = 'HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization'

New-Item -Path $speech_policy_key -Force | Out-Null

New-ItemProperty `
    -Path $speech_policy_key `
    -Name 'AllowInputPersonalization' `
    -PropertyType DWord `
    -Value 0 `
    -Force | Out-Null


# Disable activity history and activity uploads

$system_policy_key = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System'

New-Item -Path $system_policy_key -Force | Out-Null

foreach ($setting in @(
    'EnableActivityFeed'
    'PublishUserActivities'
    'UploadUserActivities'
)) {
    New-ItemProperty `
        -Path $system_policy_key `
        -Name $setting `
        -PropertyType DWord `
        -Value 0 `
        -Force | Out-Null
}


# Disable tracking of application launches

$explorer_advanced_key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'

New-Item -Path $explorer_advanced_key -Force | Out-Null

New-ItemProperty `
    -Path $explorer_advanced_key `
    -Name 'Start_TrackProgs' `
    -PropertyType DWord `
    -Value 0 `
    -Force | Out-Null


# Disable Windows feedback requests

$siuf_rules_key = 'HKCU:\Software\Microsoft\Siuf\Rules'

New-Item -Path $siuf_rules_key -Force | Out-Null

New-ItemProperty `
    -Path $siuf_rules_key `
    -Name 'NumberOfSIUFInPeriod' `
    -PropertyType DWord `
    -Value 0 `
    -Force | Out-Null

# Disable Cortana and web search integration

$windows_search_policy_key = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'

New-Item -Path $windows_search_policy_key -Force | Out-Null

$windows_search_settings = @{
    AllowCortana       = 0
    AllowSearchToUseLocation = 0
    DisableWebSearch   = 1
    ConnectedSearchUseWeb = 0
}

foreach ($setting in $windows_search_settings.GetEnumerator()) {
    New-ItemProperty `
        -Path $windows_search_policy_key `
        -Name $setting.Key `
        -PropertyType DWord `
        -Value $setting.Value `
        -Force | Out-Null
}

# Uninstall selected preinstalled Store apps for the current user
$apps_to_remove = @(
    'Microsoft.BingNews'
    'Microsoft.BingWeather'
    'Microsoft.Microsoft3DViewer'
    'Microsoft.Getstarted'
    'Microsoft.WindowsFeedbackHub'
    'Microsoft.WindowsMaps'
    'Microsoft.People'
    'Microsoft.ZuneVideo'
    'Microsoft.ZuneMusic'
    'Microsoft.YourPhone'
    'Microsoft.SkypeApp'
    'Microsoft.MicrosoftOfficeHub'
    'Microsoft.Wallet'
)


foreach ($app_name in $apps_to_remove) {
    $app_packages = Get-AppxPackage -Name $app_name

    if ($null -eq $app_packages) {
        Write-Host "App not installed; skipping: $app_name"
        continue
    }

    foreach ($app_package in $app_packages) {
        Write-Host "Removing app: $($app_package.Name)"

        Remove-AppxPackage -Package $app_package.PackageFullName
    }
}

# Disable Xbox Game Bar recording and background capture

$game_dvr_policy_key = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR'

New-Item -Path $game_dvr_policy_key -Force | Out-Null

New-ItemProperty `
    -Path $game_dvr_policy_key `
    -Name 'AllowGameDVR' `
    -PropertyType DWord `
    -Value 0 `
    -Force | Out-Null


$game_dvr_key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR'
$game_config_key = 'HKCU:\System\GameConfigStore'

New-Item -Path $game_dvr_key -Force | Out-Null
New-Item -Path $game_config_key -Force | Out-Null

New-ItemProperty `
    -Path $game_dvr_key `
    -Name 'AppCaptureEnabled' `
    -PropertyType DWord `
    -Value 0 `
    -Force | Out-Null

New-ItemProperty `
    -Path $game_config_key `
    -Name 'GameDVR_Enabled' `
    -PropertyType DWord `
    -Value 0 `
    -Force | Out-Null


# Remove Xbox Game Bar for the current user, if installed
$game_bar_package = Get-AppxPackage -Name 'Microsoft.XboxGamingOverlay'

if ($null -ne $game_bar_package) {
    Remove-AppxPackage -Package $game_bar_package.PackageFullName
}

# Prevent OneDrive from starting automatically
$onedrive_run_key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'

if (Test-Path -LiteralPath $onedrive_run_key) {
    $onedrive_run = Get-ItemProperty -LiteralPath $onedrive_run_key

    if ($onedrive_run.PSObject.Properties.Name -contains 'OneDrive') {
        Remove-ItemProperty `
            -Path $onedrive_run_key `
            -Name 'OneDrive' `
            -Force
    }
}

