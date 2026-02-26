# setup-display-fonts.ps1
# Sets system font to "Segoe UI Variable Display Semib" and text scaling to 120%.
# Broadcasts WM_SETTINGCHANGE so Explorer picks up changes without sign-out.
# Run as current user (no admin required for these registry keys).

$fontName = "Segoe UI Variable Display Semib"
$textScaleFactor = 120

# --- Set text scaling to 120% ---
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Accessibility" `
    -Name "TextScaleFactor" -Value $textScaleFactor -Type DWord

# --- Build LOGFONT binary for each WindowMetrics font value ---
# LOGFONT struct is 92 bytes. Key fields:
#   Offset  0 (4 bytes): lfHeight (negative = character height in logical units)
#   Offset  4 (4 bytes): lfWidth
#   Offset 16 (4 bytes): lfWeight  (400=Regular, 600=SemiBold, 700=Bold)
#   Offset 28 (1 byte):  lfFaceName (up to 32 chars, null-terminated, UTF-16LE)

function New-LogFont {
    param(
        [string]$FaceName,
        [int]$Height = -12,
        [int]$Weight = 600
    )

    $bytes = New-Object byte[] 92

    # lfHeight (int32, little-endian)
    [Array]::Copy([BitConverter]::GetBytes([int32]$Height), 0, $bytes, 0, 4)

    # lfWeight (int32 at offset 16)
    [Array]::Copy([BitConverter]::GetBytes([int32]$Weight), 0, $bytes, 16, 4)

    # lfCharSet (offset 23) = 1 (DEFAULT_CHARSET)
    $bytes[23] = 1

    # lfQuality (offset 26) = 5 (CLEARTYPE_QUALITY)
    $bytes[26] = 5

    # lfFaceName starts at offset 28, max 32 UTF-16LE chars (64 bytes)
    $nameBytes = [System.Text.Encoding]::Unicode.GetBytes($FaceName)
    $copyLen = [Math]::Min($nameBytes.Length, 62)  # leave room for null terminator
    [Array]::Copy($nameBytes, 0, $bytes, 28, $copyLen)

    return $bytes
}

$logFont = New-LogFont -FaceName $fontName -Height -12 -Weight 600

$metricsPath = "HKCU:\Control Panel\Desktop\WindowMetrics"

# These are the font values Winaero Tweaker sets:
$fontProperties = @(
    "CaptionFont"
    "SmCaptionFont"
    "MenuFont"
    "StatusFont"
    "MessageFont"
)

foreach ($prop in $fontProperties) {
    Set-ItemProperty -Path $metricsPath -Name $prop -Value $logFont -Type Binary
}

# IconFont uses the same value
Set-ItemProperty -Path $metricsPath -Name "IconFont" -Value $logFont -Type Binary

# --- Broadcast WM_SETTINGCHANGE to force Explorer to re-read settings ---
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class NativeMethods {
    [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
    public static extern IntPtr SendMessageTimeout(
        IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam,
        uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);

    public static void BroadcastSettingChange() {
        IntPtr HWND_BROADCAST = (IntPtr)0xffff;
        uint WM_SETTINGCHANGE = 0x001A;
        uint SMTO_ABORTIFHUNG = 0x0002;
        UIntPtr result;

        SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, UIntPtr.Zero,
            "WindowMetrics", SMTO_ABORTIFHUNG, 5000, out result);
        SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, UIntPtr.Zero,
            "Accessibility", SMTO_ABORTIFHUNG, 5000, out result);
    }
}
"@

[NativeMethods]::BroadcastSettingChange()

Write-Host "System font set to '$fontName' (weight 600, SemiBold)"
Write-Host "Text scaling set to $textScaleFactor%"
Write-Host "WM_SETTINGCHANGE broadcast sent — Explorer should update without sign-out."
