# Docker image variants' definitions
$local:VARIANTS_MATRIX = @(
    @{
        package = 'ansible'
        package_version = 'v2.3.0.0'
        distro = 'alpine'
        distro_version = '3.6'
        subvariants = @(
            @{ components = $null }
            @{ components = 'ssh' }
        )
    }
    @{
        package = 'ansible'
        package_version = 'v2.4.6.0'
        distro = 'alpine'
        distro_version = '3.7'
        subvariants = @(
            @{ components = $null }
            @{ components = 'ssh' }
        )
    }
    @{
        package = 'ansible'
        package_version = 'v2.6.19'
        distro = 'alpine'
        distro_version = '3.8'
        subvariants = @(
            @{ components = $null }
            @{ components = 'ssh' }
        )
    }
    @{
        package = 'ansible'
        package_version = 'v2.7.13'
        distro = 'alpine'
        distro_version = '3.9'
        subvariants = @(
            @{ components = $null }
            @{ components = 'ssh' }
        )
    }
    @{
        package = 'ansible'
        package_version = 'v2.8.4'
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
                    distro = $variant['distro']
                    distro_version = $variant['distro_version']
                    components = $subVariant['components']
                }
                tag = @(
                        $variant['package_version']
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
