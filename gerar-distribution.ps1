$filesRoot = "C:\CobbleverseDistribution\repo\files"

$modules = @()

$lfsPaths = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
& git -C 'C:\CobbleverseDistribution' lfs ls-files -n | ForEach-Object { [void]$lfsPaths.Add($_) }

Get-ChildItem $filesRoot -Recurse -File | ForEach-Object {

    $relativePath = $_.FullName.Substring($filesRoot.Length + 1).Replace("\", "/")
   $hash = (Get-FileHash -LiteralPath $_.FullName -Algorithm MD5).Hash.ToLower()
    $repoPath = "repo/files/$relativePath"
    $baseUrl = if ($lfsPaths.Contains($repoPath)) { "https://media.githubusercontent.com/media/Peulim/CobbleverseDistribution/main/repo/files" } else { "https://raw.githubusercontent.com/Peulim/CobbleverseDistribution/main/repo/files" }

    $modules += [ordered]@{
        id   = "cobbleverse:$($relativePath.Replace('/', '_'))"
        name = $_.Name
        type = "File"

        artifact = [ordered]@{
            size = $_.Length
            MD5  = $hash
            path = $relativePath
            url  = "$baseUrl/$relativePath"
        }
    }
}

$fabric = [ordered]@{
    id   = "net.fabricmc:fabric-loader:0.18.4"
    name = "Fabric Loader"
    type = "Fabric"

    artifact = [ordered]@{
        size = 1944518
        MD5  = "56c00fa22e0452e8567be1feae73c3b9"
        url  = "https://raw.githubusercontent.com/Peulim/CobbleverseDistribution/main/repo/lib/net/fabricmc/fabric-loader/0.18.4/fabric-loader-0.18.4.jar"
    }

    subModules = @(
        [ordered]@{
            id   = "1.21.1-fabric-0.18.4"
            name = "Fabric Version Manifest"
            type = "VersionManifest"

            artifact = [ordered]@{
                size = 4874
                MD5  = "6bd7d56e3c4453ece93e841fb0155f14"
                url  = "https://raw.githubusercontent.com/Peulim/CobbleverseDistribution/main/repo/versions/1.21.1-fabric-0.18.4/1.21.1-fabric-0.18.4.json"
            }
        }
    )
}

$modules = @($fabric) + $modules

$distribution = [ordered]@{
    version = "1.0.0"

    servers = @(
        [ordered]@{
            id               = "Cobbleverse-1.21.1"
            name             = "Cobbleverse"
            description      = "Cobbleverse - Pokemon Adventure"
            version          = "1.0.0"
            address          = "enx-cirion-128.enx.host:10283"
            minecraftVersion = "1.21.1"
            mainServer       = $true
            autoconnect      = $false
            modules          = $modules
        }
    )
}

$distribution |
    ConvertTo-Json -Depth 20 |
    Set-Content "C:\CobbleverseDistribution\distribution.json" -Encoding UTF8

Write-Host "distribution.json criado com sucesso!"
Write-Host "Modulos gerados:" $modules.Count
