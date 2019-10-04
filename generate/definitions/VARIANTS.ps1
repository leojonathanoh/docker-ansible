# Docker image variants' definitions
$VARIANTS = @(
    @{
        tag = 'v2.6-alpine-3.8'
        distro = 'alpine-3.8'
    }
    @{
        tag = 'v2.6-ssh-alpine-3.8'
        distro = 'alpine-3.8'
    }
    @{
        tag = 'v2.7-alpine-3.9'
        distro = 'alpine-3.9'
    }
    @{
        tag = 'v2.7-ssh-alpine-3.9'
        distro = 'alpine-3.9'
    }
    @{
        tag = 'v2.8-alpine-3.10'
        distro = 'alpine-3.10'
    }
    @{
        tag = 'v2.8-ssh-alpine-3.10'
        distro = 'alpine-3.10'
    }
)

# Docker image variants' definitions (shared)
$VARIANTS_SHARED = @{
    buildContextFiles = @{
        templates = @{
            'Dockerfile' = @{
                common = $false
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
