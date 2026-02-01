# install powershell 7 and enable running scripts:
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$dest = "C:\dev\orgme\clipboard.png"
$lastHash = ""

while ($true) {
    try {
        if ([System.Windows.Forms.Clipboard]::ContainsImage()) {
            $img = [System.Windows.Forms.Clipboard]::GetImage()
            $ms = New-Object System.IO.MemoryStream
            $img.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
            $hash = (Get-FileHash -InputStream $ms).Hash

            if ($hash -ne $lastHash) {
                $img.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
                $lastHash = $hash
                Write-Host "Clipboard image updated"
            }
        }
    } catch {
        # transient clipboard lock, ignore
    }
    Start-Sleep -Milliseconds 500
}
