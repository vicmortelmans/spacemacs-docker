# install powershell 7 and enable running scripts:
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$dest = "C:\dev\orgme\clipboard.png"
$lastHash = ""

while ($true) {
    try {
        if ([System.Windows.Forms.Clipboard]::ContainsImage()) {

            # Copy image to avoid locking the clipboard
            $src = [System.Windows.Forms.Clipboard]::GetImage()
            if ($src -ne $null) {

                # Clone the image so we can dispose safely
                $img = $src.Clone()
                $src.Dispose()

                # Hash the cloned image
                $ms = New-Object System.IO.MemoryStream
                $img.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)

                $ms.Position = 0   # important!
                $hash = (Get-FileHash -InputStream $ms -Algorithm SHA256).Hash

                if ($hash -ne $lastHash) {
                    # Save to disk
                    $img.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
                    Write-Host "Clipboard image updated"

                    $lastHash = $hash
                }

                $img.Dispose()
                $ms.Dispose()
            }
        }
    }
    catch {
        # clipboard busy etc.
    }

    Start-Sleep -Milliseconds 400
}
