@"
# docker-ansible

[![github-actions](https://github.com/leojonathanoh/docker-ansible/workflows/ci-master-pr/badge.svg)](https://github.com/leojonathanoh/docker-ansible/actions)
[![docker-image-size](https://img.shields.io/microbadger/image-size/leojonathanoh/docker-ansible/latest)](https://hub.docker.com/r/leojonathanoh/docker-ansible)
[![docker-image-layers](https://img.shields.io/microbadger/layers/leojonathanoh/docker-ansible/latest)](https://hub.docker.com/r/leojonathanoh/docker-ansible)

Dockerized ``ansible`` alpine image with useful tools.

| Tags |
|:-------:|
$(
($VARIANTS | % {
    if ( $_['tag_as_latest'] ) {
@"
| ``:$( $_['tag'] )``, ``:latest`` |

"@
    }else {
@"
| ``:$( $_['tag'] )`` |

"@
    }
}) -join ''
)
"@
