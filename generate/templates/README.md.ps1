@"
# docker-ansible

[![pipeline status](https://gitlab.com/leojonathanoh/docker-ansible/badges/dev/pipeline.svg)](https://gitlab.com/leojonathanoh/docker-ansible/commits/dev)

Dockerized ``ansible`` alpine image with some optional tools

| Tags |
|:-------:| $( $VARIANTS | % {
"`n| ``:$( $_['tag'] )`` |"
})

"@
