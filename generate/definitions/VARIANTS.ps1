# Docker image variants' definitions
# Since v2.10, ansible has been split into two packages, namely ansible-core and ansible
# See: https://docs.ansible.com/ansible/latest/reference_appendices/faq.html#where-did-all-the-modules-go
# See: https://wiki.archlinux.org/index.php?title=Ansible&action=history
$local:VARIANTS_MATRIX = @(
    @{
        package = 'ansible'
        package_version = '10.5.0'
        distro = 'alpine'
        distro_version = 'edge'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh', 'step' ) }
        )
    }
    @{
        package = 'ansible'
        package_version = '9.5.1'
        distro = 'alpine'
        distro_version = '3.20'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh', 'step' ) }
        )
    }
    @{
        package = 'ansible'
        package_version = '8.6.1'
        distro = 'alpine'
        distro_version = '3.19'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh', 'step' ) }
        )
    }
    @{
        package = 'ansible'
        package_version = '7.5.0'
        distro = 'alpine'
        distro_version = '3.18'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh', 'step' ) }
        )
    }
    @{
        package = 'ansible'
        package_version = '6.6.0'
        distro = 'alpine'
        distro_version = '3.17'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh', 'step' ) }
        )
    }
    @{
        package = 'ansible'
        package_version = '5.8.0'
        distro = 'alpine'
        distro_version = '3.16'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh', 'step' ) }
        )
    }
    @{
        package = 'ansible'
        package_version = '4.8.0'
        distro = 'alpine'
        distro_version = '3.15'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh', 'step' ) }
        )
    }
    @{
        package = 'ansible'
        package_version = '2.10.7'
        distro = 'alpine'
        distro_version = '3.13'
        subvariants = @(
            @{ components = $null }
            @{ components = @( 'sops', 'ssh', 'step' ) }
        )
    }
    @{
        package = 'ansible'
        package_version = '2.9.18'
        distro = 'alpine'
        distro_version = '3.11'
        subvariants = @(
            @{ components = $null }
            @{ components = @( 'sops', 'ssh', 'step' ) }
        )
    }
    @{
        package = 'ansible'
        package_version = '2.8.19'
        distro = 'alpine'
        distro_version = '3.10'
        subvariants = @(
            @{ components = $null }
            @{ components = @( 'sops', 'ssh', 'step' ) }
        )
    }
    @{
        package = 'ansible'
        package_version = '2.7.17'
        distro = 'alpine'
        distro_version = '3.9'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh', 'step' ) }
        )
    }
    @{
        package = 'ansible'
        package_version = '2.6.20'
        distro = 'alpine'
        distro_version = '3.8'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh', 'step' ) }
        )
    }
    @{
        package = 'ansible'
        package_version = '2.4.6.0'
        distro = 'alpine'
        distro_version = '3.7'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh', 'step' ) }
        )
    }
    @{
        package = 'ansible'
        package_version = '2.3.0.0'
        distro = 'alpine'
        distro_version = '3.6'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'sops', 'ssh', 'step' ) }
        )
    }
)
$VARIANTS = @(
    foreach ($variant in $VARIANTS_MATRIX){
        foreach ($subVariant in $variant['subvariants']) {
            @{
                # Metadata object
                _metadata = @{
                    package = $variant['package']
                    package_version = $variant['package_version']
                    distro = $variant['distro']
                    distro_version = $variant['distro_version']
                    platforms = & {
                        if ($variant['distro'] -eq 'alpine' -and $variant['distro_version'] -in @('3.3', '3.4', '3.5')) {
                            'linux/amd64'
                        }else {
                            if ($subVariant['components'] -contains 'step') {
                                'linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64'
                            }else {
                                'linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/s390x'
                            }
                        }
                    }
                    components = $subVariant['components']
                    job_group_key = $variant['package_version']
                }
                # Docker image tag. E.g. '7.5.0-alpine-3.18'
                tag = @(
                        $variant['package_version']
                        $subVariant['components'] | ? { $_ }
                        $variant['distro']
                        $variant['distro_version']
                ) -join '-'
                tag_as_latest = if ($variant['package_version'] -eq $local:VARIANTS_MATRIX[0]['package_version'] -and $subVariant['components'].Count -eq 0) { $true } else { $false }
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
                includeHeader = $false
                includeFooter = $false
                passes = @(
                    @{
                        variables = @{}
                    }
                )
            }
            'docker-entrypoint.sh' = @{
                common = $true
                passes = @(
                    @{
                        variables = @{}
                    }
                )
            }
        }
    }
}
