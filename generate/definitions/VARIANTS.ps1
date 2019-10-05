# Docker image variants' definitions
$local:VARIANTS_MATRIX = @(
    @{
        package = 'ansible'
        package_version = '2.3.0.0-r1'
        distro = 'alpine'
        distro_version = '3.6'
        subvariants = @(
            @{ components = $null }
            @{ components = 'ssh' }
        )
    }
    @{
        package = 'ansible'
        package_version = '2.4.6.0-r1'
        distro = 'alpine'
        distro_version = '3.7'
        subvariants = @(
            @{ components = $null }
            @{ components = 'ssh' }
        )
    }
    @{
        package = 'ansible'
        package_version = '2.6.19-r0'
        distro = 'alpine'
        distro_version = '3.8'
        subvariants = @(
            @{ components = $null }
            @{ components = 'ssh' }
        )
    }
    @{
        package = 'ansible'
        package_version = '2.7.13-r0'
        distro = 'alpine'
        distro_version = '3.9'
        subvariants = @(
            @{ components = $null }
            @{ components = 'ssh' }
        )
    }
    @{
        package = 'ansible'
        package_version = '2.8.4-r0'
        distro = 'alpine'
        distro_version = '3.10'
        subvariants = @(
            @{ components = $null }
            @{ components = 'ssh' }
        )
    }
)
$VARIANTS = @(
    foreach ($variant in $VARIANTS_MATRIX){
        foreach ($subVariant in $variant['subvariants']) {
            @{
                _metadata = @{
                    package = $variant['package']
                    package_version = $variant['package_version']
                    package_version_semver = "v$( $variant['package_version'] )" -replace '-r\d+', ''
                    distro = $variant['distro']
                    distro_version = $variant['distro_version']
                    components = $subVariant['components']
                }
                tag = @(
                        "v$( $variant['package_version'] )" -replace '-r\d+', ''
                        $subVariant['components'] | ? { $_ }
                        $variant['distro']
                        $variant['distro_version']
                ) -join '-'
            }
        }
    }
)

# Docker image variants' definitions (shared)
$VARIANTS_SHARED = @{
    buildContextFiles = @{
        templates = @{
            'Dockerfile' = @{
                common = $true
                includeHeader = $true
                includeFooter = $true
                passes = @(
                    @{
                        variables = @{}
                    }
                )
            }
        }
    }
}

# Send definitions down the pipeline
$VARIANTS
