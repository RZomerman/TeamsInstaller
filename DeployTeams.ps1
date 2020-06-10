#Setting Registry
$registryPath = "HKLM:\SOFTWARE\Microsoft\Teams"
$Name = "IsWVDEnvironment"
$value = "1"
New-ItemProperty -Path $registryPath -Name $name -Value $value `
    -PropertyType DWORD -Force | Out-Null

Invoke-WebRequest -Uri https://aka.ms/vs/16/release/vc_redist.x64.exe -useBasicParsing -outfile $env:TEMP\vc_redist.x64.exe
Invoke-WebRequest -Uri https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4vkL6 -useBasicParsing -outfile $env:TEMP\MsRdcWebRTCSvc_HostSetup_0.11.0_x64.msi
Invoke-WebRequest -Uri https://statics.teams.cdn.office.net/production-windows-x64/1.3.00.4461/Teams_windows_x64.msi -useBasicParsing -outfile $env:TEMP\Teams_windows_x64.msi


cd $env:TEMP
#Installing VCRedist: 
write-host "Instaling VCRedist"
.\vc_redist.x64.exe /install /passive

#InstallingRTCClient
write-host "Running Web RTC"
msiexec /i $env:TEMP\MsRdcWebRTCSvc_HostSetup_0.11.0_x64.msi /passive

#Installing Teams
write-host "Installing teams with ALL USERS"
msiexec /i $env:TEMP\Teams_windows_x64.msi /passive

Write-host 'Install done - to get Teams, please logoff and login again.. and it will initiate the user base install and place iconss' -foregroundColor Yellow