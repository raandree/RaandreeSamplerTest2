function Test-Is64BitOperatingSystem {
    $osVersion = [System.Environment]::Is64BitOperatingSystem
    return "Version: $($osVersion.Version), Platform: $($osVersion.Platform), Service Pack: $($osVersion.ServicePack)"
}
