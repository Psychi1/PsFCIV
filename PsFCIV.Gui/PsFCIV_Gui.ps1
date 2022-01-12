Import-Module PsFCIV

# https://theitbros.com/powershell-gui-for-scripts/
# https://www.pkisolutions.com/tools/psfciv/

$sFolder="Y:\LANUV\Abt6\FB64\FB64.4\Qualitätsmanagment\Ergebnisse"
$sExclude=$sFolder+ "\_Freigabe"
Set-Location $sFolder

Add-Type -assembly System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='PsFCIV: Gui'
$main_form.Width = 400
$main_form.Height = 200

$Label = New-Object System.Windows.Forms.Label
$Label.Text = "Funktion: "
$Label.Location  = New-Object System.Drawing.Point(0,10)
$Label.AutoSize = $true
$main_form.Controls.Add($Label)

$Label2 = New-Object System.Windows.Forms.Label
$Label2.Text = ""
$Label2.Font =  [System.Drawing.Font]::new("Bahnschrift", 20, [System.Drawing.FontStyle]::Bold)
$Label2.ForeColor='green'
$Label2.Location  = New-Object System.Drawing.Point(20,50)
$Label2.AutoSize = $true
$main_form.Controls.Add($Label2)

$Label3 = New-Object System.Windows.Forms.Label
$Label3.ForeColor='Gray'
$Label3.Text = "Fragen: Dr. Uwe Bieling, LANUV 64.4, Version: 2022-01-11"
$Label3.Location  = New-Object System.Drawing.Point(5,140)
$Label3.AutoSize = $true
$main_form.Controls.Add($Label3)

$ComboBox = New-Object System.Windows.Forms.ComboBox
$ComboBox.Width = 310
$ComboBox.Items.Add("Datenbank erstellen");
$ComboBox.Items.Add("Datenbank prüfen");
$ComboBox.Items.Add("Neue Dateien hinzufügen");
$ComboBox.Items.Add("QuickCheck");
$ComboBox.SelectedIndex = 1
$ComboBox.Location  = New-Object System.Drawing.Point(60,10)
$main_form.Controls.Add($ComboBox)

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(250,50)
$Button.Size = New-Object System.Drawing.Size(120,20)
$Button.Text = "Los ..."
$main_form.Controls.Add($Button)

$Button2 = New-Object System.Windows.Forms.Button
$Button2.Location = New-Object System.Drawing.Size(250,80)
$Button2.Size = New-Object System.Drawing.Size(120,20)
$Button2.Text = "Schließen"
$main_form.Controls.Add($Button2)

$Button2.Add_Click({
    $main_form.close()
})

$Button.Add_Click(
{
    $Label2.ForeColor='black'
    $Label2.Text = "Bitte warten...`ndas dauert jetzt"

    Start-Sleep -Seconds 1.5

   switch ( $ComboBox.selectedItem )
{
    "Datenbank erstellen"
    {
       Start-PsFCIV -Path $sFolder -XML DB64.4.XML -Exclude $sExclude -HashAlgorithm SHA256 -Recurse
    }
    "Datenbank prüfen"
    {
       Start-PsFCIV -Path $sFolder -XML DB64.4.XML -Exclude $sExclude -HashAlgorithm SHA256 -Recurse -Show New, Bad, Missed
    }
    "Neue Dateien hinzufügen"
    {
       Start-PsFCIV -Path $sFolder -XML DB64.4.XML -Exclude $sExclude -HashAlgorithm SHA256 -Recurse -Rebuild
    }
    "QuickCheck"
    {
       Write-Host "QuickCheck"
    }
}
    $Label2.ForeColor='green'
    $Label2.Text = "FERTIG"  
}
)

$main_form.ShowDialog()

# SIG # Begin signature block
# MIIPRgYJKoZIhvcNAQcCoIIPNzCCDzMCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUUttYsSj64NlBAyj5FmPAfFpA
# XkegggyaMIIFsjCCA5qgAwIBAgITXgAAAA0wm1PVjaHdlQAFAAAADTANBgkqhkiG
# 9w0BAQsFADBcMRIwEAYKCZImiZPyLGQBGRYCZGUxEzARBgoJkiaJk/IsZAEZFgNu
# cncxFTATBgoJkiaJk/IsZAEZFgVsYW51djEaMBgGA1UEAxMRTEFOVVYgTlJXIFJv
# b3QtQ2EwHhcNMjExMDEzMTQyMTAzWhcNMjYxMDEzMTQzMTAzWjBeMRIwEAYKCZIm
# iZPyLGQBGRYCZGUxEzARBgoJkiaJk/IsZAEZFgNucncxFTATBgoJkiaJk/IsZAEZ
# FgVsYW51djEcMBoGA1UEAxMTTEFOVVYgTlJXIFN1Yi1DQSBNUzCCASIwDQYJKoZI
# hvcNAQEBBQADggEPADCCAQoCggEBAMwf4GddVmKYSomZPao8TAhnZERhxWvAKqNf
# +gzL3MrhQn+MsjrKf9u1BX5Jk/GGcBpkX1cjzr2dxmWaXuCt//3JOUPxzn+seLXy
# i74fBKF4iDXehZ+dc75licVUjHG2VBRVQzmozCJ5hlOt5Ay/ZmdJA5ox94N7n6dl
# puaPPdE6esq2rEAmdsfysMgRS7YEuKetJpWcf+f4Ntu2O9p+udnYGQ8agFPKqftE
# BtMG80xVd11Dqj73sVDxva9+x/38XgJfzN8jSLwsbF3b03kHzumo8AM+i1x+jtgr
# jsohQ7oGR33Bow4ogQ8wHeVevhhynQ5XnJ1iQIubxzofaniQlF8CAwEAAaOCAWkw
# ggFlMBAGCSsGAQQBgjcVAQQDAgEGMCMGCSsGAQQBgjcVAgQWBBSB0qvdsBInYxn2
# pkd+kU00nE6puzAdBgNVHQ4EFgQULaTMoEucSk+YJGPwKc75r8gg1rMwGQYJKwYB
# BAGCNxQCBAweCgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMB
# Af8wHwYDVR0jBBgwFoAUNn601L+Ve5TJO5HeoxC9ETmoz3gwVAYDVR0fBE0wSzBJ
# oEegRYZDaHR0cDovL3ctcmUxMi1saXoubGFudXYubnJ3LmRlL0NlcnRFbnJvbGwv
# TEFOVVYlMjBOUlclMjBSb290LUNhLmNybDBdBggrBgEFBQcBAQRRME8wTQYIKwYB
# BQUHMAKGQWZpbGU6Ly8vL3ctcmUxMi1saXovUm9vdENSTC9XLVJFMTItUm9vdENh
# TEFOVVYlMjBOUlclMjBSb290LUNhKDUpMA0GCSqGSIb3DQEBCwUAA4ICAQBQhWCc
# 5RSrYI7x6dNJ2csuD95ezX9F8uQVtaX+REXguLs0S2YDD5c1yQcDYgdkb2tVD+vu
# r14r5RAHjQtFwmHSLDsFrUtsid+ZoNLn5kjRVB5Y9kBhuIRapylaSc/b0t8m+Nve
# ucgbOuUaVUS/deo5UfN0wd4gSTVF6H7diCvwEipYsD0xiNmPg8kzo/XwqvcXFC82
# GYvksskq8TwBW1R+YYR7QSeY+IwaVZvCo4cf2/wqeLvp0Ewci+kUghcgnrawr311
# ffROnbkUZzgJOQcyZgbq3VjziayQndmLPwIitJeQcFTCKAbssIkIjPAFjB4cYQmR
# kxOxlZus8I6nqyaO3yM4Axq0QUdiDL4jQzhvJjs12g9Ah2DLx2XObAoA6MYNYLCZ
# D3pMekrGOZVHl+9i387ciEXlYDEiQQAEvpvjRgsmJSRuNg7HtlicSgkHRG/TCSNb
# FFKW9BQD0djCEo+NwwlmUy9gEm5OQneecN2XpbeUMg37faA7fOyBCpy9NsbOVV4C
# 3yRCV970D/EEJodNEGxNWxMmVKe2ttXh61IRP7MVYmB10GOFq8i5FS8ksz1D9gLE
# MQzRg2StzmwJvkwHVTgMc26ThkAA1tbS+LjQa9eODzIFpQ+vgb6XCdRHukL/lh2h
# gaEyjkkYX+/3W45llBhr71MYggxVqew2mtoBqzCCBuAwggXIoAMCAQICE1EAAUjf
# dKMTmH8gPz8ABQABSN8wDQYJKoZIhvcNAQELBQAwXjESMBAGCgmSJomT8ixkARkW
# AmRlMRMwEQYKCZImiZPyLGQBGRYDbnJ3MRUwEwYKCZImiZPyLGQBGRYFbGFudXYx
# HDAaBgNVBAMTE0xBTlVWIE5SVyBTdWItQ0EgTVMwHhcNMjAwODAzMDk0MjE0WhcN
# MjIwODAzMDk0MjE0WjBzMRIwEAYKCZImiZPyLGQBGRYCZGUxEzARBgoJkiaJk/Is
# ZAEZFgNucncxFTATBgoJkiaJk/IsZAEZFgVsYW51djEVMBMGA1UECxMMMTFMQU5V
# Vi1Vc2VyMRowGAYDVQQDExFCaWVsaW5nLCBEci4sIFV3ZTCCASIwDQYJKoZIhvcN
# AQEBBQADggEPADCCAQoCggEBAOLZ+wC0DWMk8HwyRiZkCiTHCjHMHi3jn3FvbeF0
# cN1zfRUHt6pYPdCueRLMzeO8u12C5GEx8Kqo5626EbBfRw8SojfsykPRXdOTTVjb
# Lbvmu3oSAtc2La64rZ3ElwzAtpyQKEN6CSI5B8wE24q7kj5uN7glWwmhAN7IUYss
# NqQ6W7T/zGk3bDikmKsX489Un5v5h1tuUUYm8Wz5sqmqdtr2dTGLVgnqeIM1xZLn
# r4tNf+fOtRlBVuI7JkkbqS8ruWjb3r86eCgHuZZPSgzpAjFhcjpkE/hkfPvqI9hL
# jpFQL80AsAP9W8A/xCtxzuSqhXLwqmtwhWGf2cVkjLtUeu0CAwEAAaOCA4AwggN8
# MDsGCSsGAQQBgjcVBwQuMCwGJCsGAQQBgjcVCI+Ga7XcWYKVgxeH9PMJh9GUMIFM
# g7fRGbK6LQIBZAIBDzATBgNVHSUEDDAKBggrBgEFBQcDAzALBgNVHQ8EBAMCB4Aw
# GwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDAzAdBgNVHQ4EFgQU1tu68sTRmwnS
# M1kovAJvzPdMEI4wHwYDVR0jBBgwFoAULaTMoEucSk+YJGPwKc75r8gg1rMwggEs
# BgNVHR8EggEjMIIBHzCCARugggEXoIIBE4aBx2xkYXA6Ly8vQ049TEFOVVYlMjBO
# UlclMjBTdWItQ0ElMjBNUyxDTj1XLVJFMTItTElaLENOPUNEUCxDTj1QdWJsaWMl
# MjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERD
# PWxhbnV2LERDPW5ydyxEQz1kZT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jh
# c2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGR2h0dHA6Ly9XLVJF
# MTItTElaLmxhbnV2Lm5ydy5kZS9DZXJ0RW5yb2xsL0xBTlVWJTIwTlJXJTIwU3Vi
# LUNBJTIwTVMuY3JsMIIBQQYIKwYBBQUHAQEEggEzMIIBLzCBvAYIKwYBBQUHMAKG
# ga9sZGFwOi8vL0NOPUxBTlVWJTIwTlJXJTIwU3ViLUNBJTIwTVMsQ049QUlBLENO
# PVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3Vy
# YXRpb24sREM9bGFudXYsREM9bnJ3LERDPWRlP2NBQ2VydGlmaWNhdGU/YmFzZT9v
# YmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MG4GCCsGAQUFBzAChmJo
# dHRwOi8vVy1SRTEyLUxJWi5sYW51di5ucncuZGUvQ2VydEVucm9sbC9XLVJFMTIt
# TElaLmxhbnV2Lm5ydy5kZV9MQU5VViUyME5SVyUyMFN1Yi1DQSUyME1TKDUpLmNy
# dDBJBgNVHREEQjBAoCQGCisGAQQBgjcUAgOgFgwUQmllbGluZ0BsYW51di5ucncu
# ZGWBGFV3ZS5CaWVsaW5nQGxhbnV2Lm5ydy5kZTANBgkqhkiG9w0BAQsFAAOCAQEA
# cvvDttWThhywPykry/osSoW4jUJG2VsLfBrLLMmwJsHk01KgtIox9jim2k9+2XAA
# 4gApFQknvHfgYJHlbRNjv/k+U9DQW/PtX3YiK4wMwhmEsaSNvcW4wNin6/DCAt8G
# Ubh9Pg23socbpIgjopqRWrpDBJ92MLtv4jc+NjGtcEaDtcr4esrmGJ1lYhBEj7eJ
# 9c8lbAeMmPsVbYAhmA3Vda8JV4h9toESeNhV497L5bYVcmLdRgngvT/q7QhZHzWg
# hjivlQGWCLwE+lkEUcjNmYwXynHWZfkx9lsrnpJxbhXS24Bboqu+xSgKbzzU3TAp
# fS3b0vNcUlVBt7ZJuQsoSDGCAhYwggISAgEBMHUwXjESMBAGCgmSJomT8ixkARkW
# AmRlMRMwEQYKCZImiZPyLGQBGRYDbnJ3MRUwEwYKCZImiZPyLGQBGRYFbGFudXYx
# HDAaBgNVBAMTE0xBTlVWIE5SVyBTdWItQ0EgTVMCE1EAAUjfdKMTmH8gPz8ABQAB
# SN8wCQYFKw4DAhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZI
# hvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcC
# ARUwIwYJKoZIhvcNAQkEMRYEFHZlTbG0F5fAv70AoBzzTOHgetbLMA0GCSqGSIb3
# DQEBAQUABIIBAChZyRhHf+JQLXuC1Y/LXoI+d6rXaCEgOgV1UJnedjimL5KrLo49
# zQGGugO+cxYiXQ9pIfMUNBk8VDPaVrdHj6l6Vprx4bEj9iZFpemALWMpcbuhJLbi
# UsH+lKLj1QtM0ulRunTfXLQYRcJWzS7e5FkRYjj5mL0yUZ7PgCJC/Eqon9wVfbCW
# bMQcgv9d/1XwOtzSxkXk4Yvwi1f7R9M8E1U6rBuGK2O8lhMZLN+z0fyiOQgEHFIb
# 299rpaw6YEUOoe+T0u5X9nVEDTI/wWCyRNVkRV9LSqaY/DJM8RU7OC+doI6S6aAc
# wp24hdQUiHPzJnZh2usj5g26K66s5lwBm9U=
# SIG # End signature block
