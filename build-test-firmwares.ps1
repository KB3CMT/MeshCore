# Build the build/pota-all test set. Stops at the first environment that fails.
# Run from C:\dev\MeshCore after: git switch build/pota-all
#   powershell -ExecutionPolicy Bypass -File .\build-test-firmwares.ps1

$ErrorActionPreference = "Continue"

$targets = @(
    "Heltec_v3_repeater",
    "Heltec_v3_room_server",
    "Heltec_v3_room_server_pota",
    "Heltec_v3_companion_radio_ble",
    "Heltec_v3_sensor",
    "RAK_4631_repeater",
    "RAK_4631_room_server",
    "RAK_4631_companion_radio_ble",
    "RAK_4631_sensor",
    "Xiao_S3_WIO_repeater",
    "Xiao_S3_WIO_room_server",
    "Xiao_S3_WIO_companion_radio_ble",
    "Xiao_S3_WIO_sensor",
    "Xiao_nrf52_repeater",
    "Xiao_nrf52_room_server",
    "Xiao_nrf52_companion_radio_ble",
    "WioTrackerL1_repeater",
    "WioTrackerL1_room_server",
    "WioTrackerL1_companion_radio_ble"
)

$built = @()
foreach ($target in $targets) {
    Write-Host ""
    Write-Host "=== Building $target ($($built.Count + 1) of $($targets.Count)) ==="
    & pio run -e $target
    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "FAILED: $target (exit $LASTEXITCODE)"
        if ($built.Count -gt 0) {
            Write-Host "Succeeded before this:"
            $built | ForEach-Object { Write-Host "  $_" }
        }
        exit $LASTEXITCODE
    }
    $built += $target
    Write-Host "OK: $target"
}

Write-Host ""
Write-Host "All $($targets.Count) environments built."
