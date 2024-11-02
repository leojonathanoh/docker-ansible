@"
FROM $( $VARIANT['_metadata']['distro'] ):$( $VARIANT['_metadata']['distro_version'] )
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on `$BUILDPLATFORM, building for `$TARGETPLATFORM"

# Install ansible
RUN set -eux; \
    apk add --no-cache $( $VARIANT['_metadata']['package'] )$( if ( $VARIANT['_metadata']['distro'] -eq 'alpine' -and $VARIANT['_metadata']['distro_version'] -eq '3.6' ) { '>=' } else { '~=' } )$( $VARIANT['_metadata']['package_version'] ); \
    ansible --version

RUN apk add --no-cache ca-certificates


"@

if ( $VARIANT['_metadata']['components'] -contains 'sops' ) {
    if ( $VARIANT['_metadata']['distro'] -eq 'alpine' -and $VARIANT['_metadata']['distro_version'] -eq '3.6' ) {
        @"
# Fix wget not working in alpine:3.6. https://github.com/gliderlabs/docker-alpine/issues/423
RUN apk add --no-cache libressl


"@
    }
    @"
RUN set -eux; \
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^53aec65e45f62a769ff24b7e5384f0c82d62668dd96ed56685f649da114b4dbb '; \
    sops --version

RUN apk add --no-cache gnupg


"@
}

if ( $VARIANT['_metadata']['components'] -contains 'ssh' ) {
    @"
RUN apk add --no-cache openssh-client


"@
}

if ( $VARIANT['_metadata']['components'] -contains 'step' ) {
    $STEP_VERSION = "v0.27.5"
    Generate-DownloadBinary @{
        binary = 'step'
        version = $STEP_VERSION
        archiveformat = '.tar.gz'
        archivefiles = @()
        checksumsUrl = "https://github.com/smallstep/cli/releases/download/$STEP_VERSION/checksums.txt"
        destination = '/usr/local/bin/step'
        testCommand = 'step version'
    }
}

@"
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]

"@
