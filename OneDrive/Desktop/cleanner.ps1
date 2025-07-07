Function Cleaner {
    Param (
        [String]$targetfolder = "$env:temp",
        [String[]]$extension = @("*.temp", "*.log"),
        [Switch]$dryrun
    )

    Write-Host "The cleaner is working..!"

    foreach ($ext in $extension) {
        $files = Get-ChildItem -Path $targetfolder -Recurse -Include $ext -ErrorAction SilentlyContinue

        foreach ($file in $files) {
            if ($dryrun) {
                Write-Host "Will Delete: $($file.FullName)"
            } else {
                try {
                    Remove-Item -Path $file.FullName -Force -ErrorAction Stop
                    Write-Host "Deleted: $($file.FullName)"
                } catch {
                    Write-Warning "Failed to delete: $($file.FullName) - $_"
                }
            }
        }
    }

    Write-Host "The clean-up is complete."
}
