@"
# docker-ansible

[![gitlab-ci](https://img.shields.io/gitlab/pipeline/leojonathanoh/docker-ansible/dev)](https://gitlab.com/leojonathanoh/docker-ansible/commits/dev)
[![docker-image-size](https://img.shields.io/microbadger/image-size/leojonathanoh/docker-ansible/latest)](https://hub.docker.com/r/leojonathanoh/docker-ansible)
[![docker-image-layers](https://img.shields.io/microbadger/layers/leojonathanoh/docker-ansible/latest)](https://hub.docker.com/r/leojonathanoh/docker-ansible)

Dockerized ``ansible`` alpine image with some optional tools

| Tags |
|:-------:| $( $VARIANTS | % {
"`n| ``:$( $_['tag'] )`` |"
})

"@
